import '../const/const.dart';

Widget applogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .padding(const EdgeInsets.all(8))
      .size(95, 95)
      .make();
}
