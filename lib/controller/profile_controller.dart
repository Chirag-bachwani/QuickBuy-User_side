import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_buy/const/const.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImagelink = "";
  var isloading = false.obs;

  //textfield

  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  selectImage(context) async {
    await Permission.storage.request();
    await Permission.photos.request();
    await Permission.camera.request();

    var status = await Permission.photos.status;

    if (status.isGranted) {
      VxToast.show(context, msg: "Permission Denied");
    } else {
      try {
        final img = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 70);

        if (img == null) return;
        profileImgPath.value = img.path;

        VxToast.show(context, msg: "Image selected");
      } on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    }
  }

  uplaodProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = "images/${currentuser!.uid}/filename";
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImagelink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentuser!.uid);
    await store.set({'name': name, 'password': password, 'image_url': imgUrl},
        SetOptions(merge: true));
    isloading(false);
  }

  changeAuthpassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentuser!.reauthenticateWithCredential(cred).then((value) {
      currentuser!.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
