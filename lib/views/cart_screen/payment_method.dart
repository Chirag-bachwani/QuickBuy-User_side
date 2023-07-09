import 'package:quick_buy/const/const.dart';
import 'package:quick_buy/const/lists.dart';
import 'package:quick_buy/controller/cart_controller.dart';
import 'package:quick_buy/views/home_screen/home.dart';

import '../../widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(turquoiseColor),
                  ),
                )
              : ourButton(
                  onPress: () async {
                    controller.placeMyorder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Placed Successfully");
                    Get.off(() => Home());
                  },
                  color: turquoiseColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                  textColor: whiteColor,
                  title: "Place My order",
                ),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          title:
              " Choose Payment Method".text.semiBold.color(darkFontGrey).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsimg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? turquoiseColor
                                : Colors.transparent,
                            width: 4),
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        paymentMethodsimg[index],
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.blue.withOpacity(0.4)
                            : Colors.transparent,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                          bottom: 0,
                          right: 10,
                          child: paymentMethods[index]
                              .text
                              .white
                              .semiBold
                              .size(16)
                              .make()),
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
