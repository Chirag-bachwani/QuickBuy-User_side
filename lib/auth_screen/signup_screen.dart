import 'package:quick_buy/controller/auth_controller.dart';
import 'package:quick_buy/views/home_screen/home.dart';

import '../const/const.dart';
import '../widgets_common/app_logo.dart';
import '../widgets_common/bg_widget.dart';
import '../widgets_common/custom_textfield.dart';
import '../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var repasscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.07).heightBox,
            applogoWidget(),
            5.heightBox,
            "Sign up to $appname"
                .text
                .fontFamily(bold)
                .fontWeight(FontWeight.w400)
                .size(18)
                .make(),
            10.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: name,
                      hint: namehint,
                      controller: namecontroller,
                      dontShow: false),
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailcontroller,
                      dontShow: false),
                  customTextField(
                      title: password,
                      hint: passhint,
                      controller: passwordcontroller,
                      dontShow: true),
                  customTextField(
                      title: retypepass,
                      hint: passhint,
                      controller: repasscontroller,
                      dontShow: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: forgetpassword.text.color(Vx.blue500).make()),
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                        checkColor: whiteColor,
                        activeColor: Vx.blue700,
                      ),
                      1.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: termsAndCond,
                            style: TextStyle(
                              fontFamily: bold,
                              color: Color.fromARGB(255, 26, 157, 184),
                            ),
                          ),
                          TextSpan(
                            text: " & ",
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: privacypolicy,
                            style: TextStyle(
                              fontFamily: bold,
                              color: Color.fromARGB(255, 26, 157, 184),
                            ),
                          ),
                        ])),
                      )
                    ],
                  ),
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(turquoiseColor),
                        )
                      : ourButton(
                          color: isCheck == true
                              ? const Color.fromARGB(255, 26, 157, 184)
                              : lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isloading(true);
                            if (isCheck != false) {
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                    name: namecontroller.text,
                                  );
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                              }
                            } else {
                              controller.isloading(false);
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: alreadyhaveAnAccount,
                          style: TextStyle(color: fontGrey),
                        ),
                        TextSpan(
                          text: login,
                          style: TextStyle(
                              color: turquoiseColor, fontFamily: bold),
                        ),
                      ],
                    ),
                  ).onTap(() {
                    Get.back();
                  })
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
