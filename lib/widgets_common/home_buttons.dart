import '../const/const.dart';

Widget homebuttons({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon, width: 33),
      10.heightBox,
      title!.text.fontWeight(FontWeight.w600).color(darkFontGrey).make(),
    ],
  ).box.rounded.color(whiteColor).shadowSm.size(width, height).make();
}
