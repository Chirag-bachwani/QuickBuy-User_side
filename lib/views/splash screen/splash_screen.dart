import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_buy/views/home_screen/home.dart';

import '../../auth_screen/login_screen.dart';
import '../../const/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  gotoNextScreen() {
    Future.delayed(const Duration(seconds: 4), () {
      // Get.to(() => const LoginScren());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(const LoginScren());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    gotoNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          Image.asset("assets/images/qb.gif")

          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Image.asset(
          //     icSplashBg,
          //     width: 300,
          //   ),
          // ),
          // applogoWidget(),
          // 10.heightBox,
          // appname.text.size(32).fontFamily(bold).make(),
          // 5.heightBox,
          // appversion.text.make(),
          // const Spacer(),
          // credits.text.fontFamily(semibold).make(),
          // const HeightBox(30),
        ],
      ),
    );
  }
}
