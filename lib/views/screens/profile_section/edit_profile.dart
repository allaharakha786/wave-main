import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/getx_controllers/picker_controller.dart';
import 'package:wave/controllers/getx_controllers/user_controller.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/controllers/utils/constants.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserController userController = Get.put(UserController());

  late TextEditingController nameController;

  late TextEditingController emailController;
  late PickerController pickerController;

  @override
  void initState() {
    pickerController = Get.put(PickerController());
    nameController = TextEditingController(text: userController.userData.value?.name);
    emailController = TextEditingController(text: userController.userData.value?.email);
    super.initState();
  }

  // callMethod() async {
  //   await userController.fetchUserProfile();
  // }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Edit Profile'),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: mediaQuerySize.width * 0.02),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GestureDetector(
          child: SizedBox(
            width: mediaQuerySize.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                child: Column(children: [
                  Stack(
                    children: [
                      Container(
                        height: mediaQuerySize.height * 0.15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: pickerController.pickedImage.value?.path.isNotEmpty ?? false
                                ? FileImage(File(pickerController.pickedImage.value!.path))
                                : userController.userData.value?.profileImage.isNotEmpty ?? false
                                    ? NetworkImage(userController.userData.value?.profileImage ?? '')
                                    : const AssetImage('assets/pngs/profile_image.png') as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 1,
                          left: mediaQuerySize.width * 0.55,
                          child: GestureDetector(
                              onTap: () {
                                pickerController.pickImage();
                              },
                              child: SvgPicture.asset('assets/svgs/camera_icon.svg')))
                    ],
                  ),
                  getVerticalSpace(height: 5.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style: AppTextStyles.regularTextStyle,
                    ),
                  ),
                  getVerticalSpace(height: .5.h),
                  customTextFormField(prefix: "assets/svgs/person.svg", title: "Lita han", controller: nameController),
                  getVerticalSpace(height: 3.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: AppTextStyles.regularTextStyle,
                    ),
                  ),
                  getVerticalSpace(height: .5.h),
                  customTextFormField(prefix: "assets/svgs/email.svg", title: "Litahan@gmail.com", controller: emailController),
                  getVerticalSpace(height: 3.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bio",
                      style: AppTextStyles.regularTextStyle,
                    ),
                  ),
                  getVerticalSpace(height: .2.h),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: AppColors.blackColor.withOpacity(0.06), borderRadius: BorderRadius.circular(12)),
                    child: const Text('My name is John Parker and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading'),
                  ),
                  getVerticalSpace(height: 6.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customElevatedButton(width: mediaQuerySize.width * 0.43, title: 'Cancel', titleColor: AppColors.primaryColor, bgColor: Colors.transparent, borderColor: AppColors.primaryColor),
                        customElevatedButton(
                          loading: pickerController.generateUrlLoading.value || userController.isLoading.value || userController.profileLoading.value ? true : false,
                          onTap: () async {
                            String path = pickerController.pickedImage.value?.path.isNotEmpty ?? false ? await pickerController.generateNetworkUrl(File(pickerController.pickedImage.value?.path ?? '')) : '';
                            Map<String, dynamic> updatedData = {
                              "name": nameController.text,
                              'profilePicture': path.isNotEmpty
                                  ? path
                                  : userController.userData.value?.profileImage.isNotEmpty ?? false
                                      ? userController.userData.value?.profileImage
                                      : ''
                            };
                            await userController.updateData(users_collection, userController.userData.value?.uid ?? '', updatedData);
                            await userController.fetchUserProfile();

                            print('path is : $path');
                          },
                          title: 'Update',
                          width: mediaQuerySize.width * 0.43,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
