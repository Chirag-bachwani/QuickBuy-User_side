import 'package:quick_buy/const/const.dart';

class Homecontroller extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var searchController = TextEditingController();

  var currentNavIndex = 0.obs;

  var username = '';

  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentuser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
  }
}
