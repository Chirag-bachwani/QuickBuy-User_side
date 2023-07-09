import 'package:quick_buy/auth_screen/signup_screen.dart';
import 'package:quick_buy/controller/auth_controller.dart';

import '../const/const.dart';
import '../const/lists.dart';
import '../views/home_screen/home.dart';
import '../widgets_common/app_logo.dart';
import '../widgets_common/bg_widget.dart';
import '../widgets_common/custom_textfield.dart';
import '../widgets_common/our_button.dart';

class LoginScren extends StatelessWidget {
  const LoginScren({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.07).heightBox,
            applogoWidget(),
            5.heightBox,
            "Log in to $appname".text.color(Vx.white).bold.size(18).make(),
            10.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: controller.emailController,
                      dontShow: false),
                  customTextField(
                      title: password,
                      hint: passhint,
                      controller: controller.passwordController,
                      dontShow: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: forgetpassword.text.color(Vx.blue500).make()),
                  ),
                  5.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(turquoiseColor),
                        )
                      : ourButton(
                          color: turquoiseColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isloading(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              } else {
                                controller.isloading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  creatnewaccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                      color: Vx.blue100,
                      title: signup,
                      textColor: const Color.fromARGB(255, 26, 157, 184),
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Vx.gray100,
                                radius: 20,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  )
                ],
              )
                  .box
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .white
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
