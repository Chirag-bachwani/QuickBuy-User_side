import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy/controller/product_controller.dart';
import 'package:quick_buy/services/firestore_sevices.dart';

import '../../const/const.dart';
import '../../widgets_common/bg_widget.dart';
import 'item_details.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    switchCategory(widget.title);
    super.initState();
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubcategoryProduct(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: whiteColor,
            )),
        title: widget.title!.text.bold.white.make(),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  controller.subcat.length,
                  (index) => "${controller.subcat[index]}"
                          .text
                          .semiBold
                          .size(12)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .white
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .size(130, 60)
                          .rounded
                          .make()
                          .onTap(() {
                        switchCategory("${controller.subcat[index]}");
                        setState(() {});
                      })),
            ),
          ),
          StreamBuilder(
            stream: productMethod,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(turquoiseColor)),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child:
                      "No products Found!".text.color(whiteColor).bold.make(),
                );
              } else {
                var data = snapshot.data!.docs;
                return Expanded(
                    child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 250),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(data[index]['p_imgs'][0],
                            width: 200, height: 150, fit: BoxFit.cover),
                        "${data[index]['p_name']}"
                            .text
                            .semiBold
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        "${data[index]['p_price']}"
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
                        .margin(const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5))
                        .roundedSM
                        .outerShadowMd
                        .padding(const EdgeInsets.all(12))
                        .make()
                        .onTap(() {
                      controller.checkifFav(data[index]);
                      Get.to(() => ItemDetails(
                          title: "${data[index]['p_name']}",
                          data: data[index]));
                    });
                  },
                ));
              }
            },
          ),
        ],
      ),
    ));
  }
}
