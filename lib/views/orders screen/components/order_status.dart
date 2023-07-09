import 'package:quick_buy/const/const.dart';

Widget orderStatus({icon, color, title, showdone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).padding(EdgeInsets.all(4)).roundedSM.make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        "$title".text.color(darkFontGrey).make(),
        showdone ? const Icon(Icons.done).box.make() : Container(),
      ]),
    ),
  );
}
