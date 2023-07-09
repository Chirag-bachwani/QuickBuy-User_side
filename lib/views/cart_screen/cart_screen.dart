import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy/controller/cart_controller.dart';
import 'package:quick_buy/services/firestore_sevices.dart';
import 'package:quick_buy/views/cart_screen/shipping_screen.dart';
import 'package:quick_buy/widgets_common/our_button.dart';

import '../../const/const.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: ourButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
        color: turquoiseColor,
        onPress: () {
          Get.to(() => const ShippingDetails());
        },
        textColor: whiteColor,
        title: "Proceed to Shipping",
      ),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart".text.color(darkFontGrey).semiBold.make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentuser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(turquoiseColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is Empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image.network(data[index]['img'])
                          .box
                          .width(80)
                          .make(),
                      title: "${data[index]['title']} (x ${data[index]['qty']})"
                          .text
                          .semiBold
                          .size(16)
                          .make(),
                      subtitle: "${data[index]['tprice']}"
                          .numCurrency
                          .text
                          .color(turquoiseColor)
                          .bold
                          .size(12)
                          .make(),
                      trailing: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ).onTap(() {
                        FirestoreServices.deleteDocument(data[index].id);
                      }),
                    );
                  },
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total Price:".text.semiBold.color(darkFontGrey).make(),
                    Obx(() => "${controller.totalP.value}"
                        .numCurrency
                        .text
                        .semiBold
                        .color(turquoiseColor)
                        .make()),
                  ],
                )
                    .box
                    .width(context.screenWidth - 60)
                    .padding(const EdgeInsets.all(12))
                    .color(Vx.yellow100)
                    .roundedSM
                    .make(),
                10.heightBox,
                // SizedBox(
                //     width: context.screenWidth - 120,
                //     child: ourButton(
                //       color: turquoiseColor,
                //       onPress: () {},
                //       textColor: whiteColor,
                //       title: "Proceed to Shipping",
                //     ))
              ]),
            );
          }
        },
      ),
    );
  }
}
