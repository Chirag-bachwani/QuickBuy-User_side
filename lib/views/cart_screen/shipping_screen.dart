import 'package:quick_buy/const/const.dart';
import 'package:quick_buy/controller/cart_controller.dart';
import 'package:quick_buy/views/cart_screen/payment_method.dart';
import 'package:quick_buy/widgets_common/custom_textfield.dart';
import 'package:quick_buy/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.semiBold.color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () {
            if (controller.addresscontroller.text.length > 10) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          color: turquoiseColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                title: "Address",
                controller: controller.addresscontroller),
            customTextField(
                hint: "City",
                title: "City",
                controller: controller.citycontroller),
            customTextField(
                hint: "State",
                title: "State",
                controller: controller.statecontroller),
            customTextField(
                hint: "Postal Code",
                title: "Postal Code",
                controller: controller.postalCodecontroller),
            customTextField(
                hint: 'Phone Number',
                title: "Phone Number",
                controller: controller.phonecontroller),
          ],
        ),
      ),
    );
  }
}
