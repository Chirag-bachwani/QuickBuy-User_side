import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy/const/const.dart';
import 'package:quick_buy/services/firestore_sevices.dart';
import 'package:quick_buy/views/orders%20screen/orders_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: " My Orders".text.color(darkFontGrey).semiBold.make(),
      ),
      backgroundColor: whiteColor,
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(turquoiseColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No Orders Placed Yet!"
                  .text
                  .color(darkFontGrey)
                  .semiBold
                  .make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}"
                      .text
                      .size(14)
                      .bold
                      .color(Vx.gray500)
                      .make(),
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(turquoiseColor)
                      .semiBold
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .bold
                      .make(),
                  trailing: SizedBox(
                    width: 40,
                    child: IconButton(
                      onPressed: () {
                        Get.to(() => OrdersDetails(data: data[index]));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: darkFontGrey,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
