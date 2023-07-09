import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy/auth_screen/login_screen.dart';
import 'package:quick_buy/controller/auth_controller.dart';
import 'package:quick_buy/controller/profile_controller.dart';
import 'package:quick_buy/services/firestore_sevices.dart';
import 'package:quick_buy/views/chat_screen/messaging_screen.dart';
import 'package:quick_buy/views/orders%20screen/orders_screen.dart';
import 'package:quick_buy/views/profile_screen/edit_profile_screen.dart';
import 'package:quick_buy/views/wishlist%20screen/wishlist_Screen.dart';

import '../../const/const.dart';
import '../../const/lists.dart';
import '../../widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  final double circleRadius = 120.0;

  @override
  Widget build(BuildContext context) {
    auth.authStateChanges().listen((user) {
      currentuser = user;
    });
    var controller = Get.put(ProfileController());

    // FirestoreServices.getCounts();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(null),
          actions: [
            TextButton(
              onPressed: () {},
              child: IconButton(
                  onPressed: () async {
                    await Get.put(AuthController()).signoutmethod(context);
                    Get.offAll(() => const LoginScren());
                  },
                  icon: const Icon(Icons.logout)),
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentuser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(turquoiseColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return Column(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 10.0, 16.0, 16.0),

                            // Here we adjust the top padding value to move the entire box lower
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: circleRadius / 2.0,
                                  ),
                                  child: Container(
                                    height: 250.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 8.0,
                                          offset: Offset(0.0, 5.0),
                                        ),
                                      ],
                                    ),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, bottom: 15.0),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: circleRadius / 2,
                                          ),
                                          Text(
                                            "${data['name']}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.0),
                                          ),
                                          Text(
                                            '${data['email']}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                                color: Colors.lightBlueAccent),
                                          ),
                                          const SizedBox(
                                            height: 45.0,
                                          ),
                                          const Spacer(),
                                          FutureBuilder(
                                            future:
                                                FirestoreServices.getCounts(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            turquoiseColor),
                                                  ),
                                                );
                                              } else {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 32.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          const Text(
                                                            'In Your Cart',
                                                            style: TextStyle(
                                                              fontSize: 14.0,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${snapshot.data[0]}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontFamily:
                                                                        ''),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: <Widget>[
                                                          const Text(
                                                            'In your Wishlist',
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          Text(
                                                            '${snapshot.data[1]}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontFamily:
                                                                        ''),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: <Widget>[
                                                          const Text(
                                                            'You Ordered',
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          Text(
                                                            '${snapshot.data[2]}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontFamily:
                                                                        ''),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                /// Image Avatar
                                Container(
                                  width: circleRadius,
                                  height: circleRadius,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8.0,
                                        offset: Offset(0.0, 5.0),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                        child: data['image_url'] == ''
                                            ? CircleAvatar(
                                                radius: 60,
                                                backgroundImage: const AssetImage(
                                                    "assets/images/user.png"),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      right: 0,
                                                      bottom: 0,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        radius: 10,
                                                        child: const Icon(
                                                                Icons.edit)
                                                            .onTap(() {
                                                          controller
                                                                  .nameController
                                                                  .text =
                                                              data['name'];

                                                          Get.to(() =>
                                                              EditProfileScreen(
                                                                  data: data));
                                                        }),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 60,
                                                backgroundImage: NetworkImage(
                                                    data['image_url']),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      right: 0,
                                                      bottom: 0,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        radius: 10,
                                                        child: const Icon(
                                                                Icons.edit)
                                                            .onTap(() {
                                                          controller
                                                                  .nameController
                                                                  .text =
                                                              data['name'];
                                                          Get.to(() =>
                                                              EditProfileScreen(
                                                                  data: data));
                                                        }),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: profilebuttonslist.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: lightGrey,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const OrdersScreen());

                              break;

                            case 1:
                              Get.to(() => const WishlistScreen());
                              break;

                            case 2:
                              Get.to(() => const MessagingScreen());

                              break;
                          }
                        },
                        leading: Image.asset(
                          profilebutonsiconlist[index],
                          width: 34,
                        ),
                        title: profilebuttonslist[index]
                            .text
                            .color(Vx.gray600)
                            .make(),
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .height(340)
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .make(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
