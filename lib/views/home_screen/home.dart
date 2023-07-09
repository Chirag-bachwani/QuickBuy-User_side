import 'package:quick_buy/widgets_common/exit_dialog.dart';

import '../../const/const.dart';
import '../../controller/home_controller.dart';
import '../cart_screen/cart_screen.dart';
import '../category_screen/category_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    
    //init home controller

    var controller = Get.put(Homecontroller());
    var navbatItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 32), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 32), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 32), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 32), label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(() => Theme(
              data: Theme.of(context).copyWith(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                  currentIndex: controller.currentNavIndex.value,
                  selectedItemColor: turquoiseColor,
                  selectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.w800),
                  backgroundColor: whiteColor,
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) {
                    controller.currentNavIndex.value = value;
                  },
                  items: navbatItem),
            )),
      ),
    );
  }
}
