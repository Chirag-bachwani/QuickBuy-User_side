import 'package:quick_buy/const/const.dart';

Widget orderPlacedDetails({String? title1, String? title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title1!.text.semiBold.make(),
            "$d1".text.color(turquoiseColor).semiBold.make()
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title2!.text.semiBold.make(),
              "$d2".text.gray500.make(),
            ],
          ),
        )
      ],
    ),
  );
}
