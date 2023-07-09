import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy/const/const.dart';
import 'dart:math';
import 'package:quick_buy/controller/home_controller.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  var addresscontroller = TextEditingController();
  var citycontroller = TextEditingController();
  var statecontroller = TextEditingController();
  var postalCodecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var vendors = [];

  var paymentIndex = 0.obs;
  var placingOrder = false.obs;

  late dynamic productSnapshot;
  var products = [];

  String generateUniqueOrderNumber() {
    DateTime now = DateTime.now();
    String timestamp = now.millisecondsSinceEpoch.toString();

    Random random = Random();
    String randomPart = random.nextInt(10000).toString().padLeft(4, '0');

    return "$timestamp-$randomPart";
  }

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyorder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);

    await getProductDetails();
    await firestore.collection(orderscollection).doc().set({
      'order_by': currentuser!.uid,
      'order_by_name': Get.find<Homecontroller>().username,
      'order_by_email': currentuser!.email,
      'order_by_address': addresscontroller.text,
      'order_by_city': citycontroller.text,
      'order_by_state': statecontroller.text,
      'order_by_postalCode': postalCodecontroller.text,
      'order_by_phone': phonecontroller.text,
      'order_by_country': 'India',
      'order_code': generateUniqueOrderNumber(),
      'order_date': DateTime.now(),
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'order_placed': true,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
      'vendors': FieldValue.arrayUnion(vendors)
    });

    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    vendors.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
