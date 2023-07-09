import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy/const/const.dart';
import 'package:quick_buy/services/firestore_sevices.dart';

import '../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(turquoiseColor)));
          } else if ((snapshot.data!.docs
                  .where(
                    (element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase()),
                  )
                  .toList())
              .isEmpty) {
            return "             No items matches your Searched text,\nTry Changing the spelling or the item does not Exist! "
                .text
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var searchdata = snapshot.data!.docs;
            var filtered = searchdata
                .where(
                  (element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()),
                )
                .toList();
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 300),
              children: filtered
                  .mapIndexed((currentValue, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(filtered[index]['p_imgs'][0],
                              width: 200, height: 200, fit: BoxFit.cover),
                          const Spacer(),
                          "${filtered[index]['p_name']}"
                              .text
                              .semiBold
                              .color(darkFontGrey)
                              .make(),
                          10.heightBox,
                          "${filtered[index]['p_price']}"
                              .numCurrency
                              .text
                              .size(16)
                              .color(turquoiseColor)
                              .bold
                              .make()
                        ],
                      )
                          .box
                          .white
                          .margin(const EdgeInsets.symmetric(horizontal: 1))
                          .roundedSM
                          .shadowMd
                          .padding(const EdgeInsets.all(12))
                          .make()
                          .onTap(() {
                        Get.to(() => ItemDetails(
                              title: "${filtered[index]['p_name']}",
                              data: filtered[index],
                            ));
                      }))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
