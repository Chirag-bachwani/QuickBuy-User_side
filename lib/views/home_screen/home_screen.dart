import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy/controller/home_controller.dart';
import 'package:quick_buy/services/firestore_sevices.dart';
import 'package:quick_buy/views/category_screen/item_details.dart';
import 'package:quick_buy/views/home_screen/search_screen.dart';

import '../../const/const.dart';
import '../../const/lists.dart';
import '../../widgets_common/home_buttons.dart';
import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Homecontroller>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: skyblue,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: skyblue,
            child: TextFormField(
              controller: controller.searchController,
              cursorColor: turquoiseColor,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  suffixIcon: Image.asset("assets/images/search.gif",
                          width: 10, height: 20)
                      .onTap(() {
                        if (controller
                            .searchController.text.isNotEmptyAndNotNull) {
                          Get.to(() => SearchScreen(
                              title: controller.searchController.text));
                        }
                      })
                      .box
                      .roundedFull
                      .make(),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: search,
                  hintStyle: const TextStyle(color: Vx.gray500)),
            ),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      viewportFraction: 0.84,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 130,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: ((context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      })),
                  const HeightBox(20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => homebuttons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todaydeal : flashsale))),
                  10.heightBox,
                  VxSwiper.builder(
                      viewportFraction: 0.84,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 130,
                      enlargeCenterPage: true,
                      itemCount: secondslidersList.length,
                      itemBuilder: ((context, index) {
                        return Image.asset(
                          secondslidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      })),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homebuttons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 3.5,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topCategories
                                  : index == 1
                                      ? brand
                                      : topSellers,
                            )),
                  ),
                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredcategories.text
                          .size(22)
                          .semiBold
                          .color(darkFontGrey)
                          .make()),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButton(
                                      title: featurestitle1[index],
                                      icon: featuredimages1[index]),
                                  10.heightBox,
                                  featuredButton(
                                      title: featurestitle2[index],
                                      icon: featuredimages2[index]),
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: turquoiseColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredproduct.text.white.semiBold.size(18).make(),
                        10.heightBox,
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getfeaturedproducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No featured Products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featureData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featureData.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featureData[index]['p_imgs'][0],
                                            width: 150,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${featureData[index]['p_name']}"
                                              .text
                                              .semiBold
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          "${featureData[index]['p_price']}"
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
                                          .size(130, 170)
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 5))
                                          .roundedSM
                                          .padding(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(() {
                                        Get.to(() => ItemDetails(
                                              title:
                                                  "${featureData[index]['p_name']}",
                                              data: featureData[index],
                                            ));
                                      }),
                                    ),
                                  );
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                      viewportFraction: 0.84,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 130,
                      enlargeCenterPage: true,
                      itemCount: secondslidersList.length,
                      itemBuilder: ((context, index) {
                        return Image.asset(
                          secondslidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      })),

                  //all products
                  20.heightBox,

                  StreamBuilder(
                    stream: FirestoreServices.allproducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(turquoiseColor),
                          ),
                        );
                      } else {
                        var allproductsdata = snapshot.data!.docs;
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsdata.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: ((context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                      allproductsdata[index]['p_imgs'][0],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover),
                                  const Spacer(),
                                  "${allproductsdata[index]['p_name']}"
                                      .text
                                      .semiBold
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${allproductsdata[index]['p_price']}"
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
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 1))
                                  .roundedSM
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetails(
                                      title:
                                          "${allproductsdata[index]['p_name']}",
                                      data: allproductsdata[index],
                                    ));
                              });
                            }));
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
