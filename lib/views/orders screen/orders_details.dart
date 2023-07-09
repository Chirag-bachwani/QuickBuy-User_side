import 'package:quick_buy/const/const.dart';
import 'package:quick_buy/views/orders%20screen/components/order_place_details.dart';
import 'package:quick_buy/views/orders%20screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.semiBold.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: Colors.red,
                  icon: Icons.done,
                  title: "Placed",
                  showdone: data['order_placed']),
              orderStatus(
                  color: Colors.green,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showdone: data['order_confirmed']),
              orderStatus(
                  color: Vx.yellow500,
                  icon: Icons.local_shipping_rounded,
                  title: "Delivery",
                  showdone: data['order_on_delivery']),
              orderStatus(
                  color: turquoiseColor,
                  icon: Icons.done_all,
                  title: "Delivered",
                  showdone: data['order_delivered']),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetails(
                      title1: "Order Code",
                      title2: "Shipping Method",
                      d1: data['order_code'],
                      d2: data['shipping_method']),
                  orderPlacedDetails(
                      title1: "Order Date",
                      title2: "Payment Method",
                      d1: intl.DateFormat()
                          .add_yMMMEd()
                          .format(data['order_date'].toDate()),
                      d2: data['payment_method']),
                  orderPlacedDetails(
                      title1: "Payment Status",
                      title2: "Delivery Status",
                      d1: "Unpaid",
                      d2: "Order Placed"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.semiBold.make(),
                            "${data['order_by_name']}"
                                .text
                                .gray500
                                .semiBold
                                .make(),
                            "${data['order_by_email']}"
                                .text
                                .gray500
                                .semiBold
                                .make(),
                            "${data['order_by_address']}"
                                .text
                                .gray500
                                .semiBold
                                .make(),
                            "${data['order_by_city']}"
                                .text
                                .gray500
                                .semiBold
                                .make(),
                            "${data['order_by_state']}"
                                .text
                                .gray500
                                .semiBold
                                .make(),
                            "${data['order_by_postalCode']}"
                                .text
                                .gray500
                                .semiBold
                                .make(),
                            "${data['order_by_phone']}"
                                .text
                                .gray500
                                .semiBold
                                .make()
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount\n\n".text.semiBold.make(),
                              "${data['total_amount']}"
                                  .numCurrency
                                  .text
                                  .color(turquoiseColor)
                                  .bold
                                  .make()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.roundedSM.make(),
              20.heightBox,
              "Ordered Product"
                  .text
                  .size(17)
                  .color(darkFontGrey)
                  .semiBold
                  .makeCentered(),
              10.heightBox,
              ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(data['orders'].length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            orderPlacedDetails(
                                title1: data['orders'][index]['title'],
                                title2: "${data['orders'][index]['tprice']}",
                                d1: "${data['orders'][index]['qty']} x ",
                                d2: "Refundable"),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                width: 30,
                                height: 20,
                                color: Color(data['orders'][index]['color']),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      }).toList())
                  .box
                  .outerShadowMd
                  .white
                  .margin(EdgeInsets.only(bottom: 4))
                  .roundedSM
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
