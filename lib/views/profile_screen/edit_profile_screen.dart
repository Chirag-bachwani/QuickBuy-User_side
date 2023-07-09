import 'dart:io';

import 'package:quick_buy/const/const.dart';
import 'package:quick_buy/controller/profile_controller.dart';
import 'package:quick_buy/widgets_common/bg_widget.dart';
import 'package:quick_buy/widgets_common/custom_textfield.dart';
import 'package:quick_buy/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['image_url'] == '' && controller.profileImgPath.isEmpty
                  ? const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/images/user.png"),
                    )
                  : data['image_url'] != '' && controller.profileImgPath.isEmpty
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(data['image_url']))
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              FileImage(File(controller.profileImgPath.value)),
                        ),
              10.heightBox,
              ourButton(
                  color: turquoiseColor,
                  textColor: whiteColor,
                  title: "Change",
                  onPress: () {
                    controller.selectImage(context);
                  }),
              const Divider(),
              20.heightBox,
              customTextField(
                controller: controller.nameController,
                hint: namehint,
                title: name,
              ),
              customTextField(
                controller: controller.oldpassController,
                hint: passhint,
                title: oldpass,
                dontShow: true,
              ),
              customTextField(
                controller: controller.newpassController,
                hint: passhint,
                title: newpass,
                dontShow: true,
              ),
              20.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(turquoiseColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 50,
                      child: ourButton(
                          color: turquoiseColor,
                          textColor: whiteColor,
                          title: "Save",
                          onPress: () async {
                            controller.isloading(true);

                            //if image is not selected

                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uplaodProfileImage();
                            } else {
                              controller.profileImagelink = data['image_url'];
                            }

                            //if old password field matches the old passsword
                            if (data['password'] ==
                                controller.oldpassController.text) {
                              controller.changeAuthpassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newpassword:
                                      controller.newpassController.text);

                              await controller.updateProfile(
                                  imgUrl: controller.profileImagelink,
                                  name: controller.nameController.text,
                                  password: controller.newpassController.text);
                              // ignore: use_build_context_synchronously
                              VxToast.show(context, msg: "Updated");
                            } else {
                              // ignore: use_build_context_synchronously
                              VxToast.show(context, msg: "Wrong Old Password");
                              controller.isloading(false);
                            }
                          }),
                    ),
            ],
          )
              .box
              .white
              .outerShadow
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        ),
      ),
    ));
  }
}
