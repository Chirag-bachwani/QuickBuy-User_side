import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy/const/const.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data, istrue) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return istrue
      ? Directionality(
          textDirection: data['uid'] == currentuser!.uid
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: data['uid'] == currentuser!.uid
                    ? turquoiseColor
                    : Vx.blue900,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "${data['msg']}".text.white.size(16).make(),
                10.heightBox,
                time.text.color(whiteColor.withOpacity(0.5)).make()
              ],
            ),
          ),
        )
      : Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color:
                  data['uid'] == currentuser!.uid ? turquoiseColor : Vx.blue900,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              "${data['msg']}".text.white.size(16).make(),
              10.heightBox,
              time.text.color(whiteColor.withOpacity(0.5)).make()
            ],
          ),
        );
}
