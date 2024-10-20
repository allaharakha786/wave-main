import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/getx_controllers/user_controller.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/controllers/utils/constants.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  late UserController userController;

  @override
  void initState() {
    userController = Get.put(UserController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Change Password'),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: mediaQuerySize.width * 0.02),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Form(
          key: formKey,
          child: GestureDetector(
            child: SizedBox(
              width: mediaQuerySize.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: Column(children: [
                    const Text(
                      "Enter the different password with the previous",
                    ),
                    getVerticalSpace(height: 5.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Old Password",
                        style: AppTextStyles.regularTextStyle,
                      ),
                    ),
                    getVerticalSpace(height: .5.h),
                    customTextFormField(
                        validator: (value) {
                          if (value!.isEmpty && value == '') {
                            return 'Please fill this field';
                          }
                          if (value != userController.userData.value?.password) {
                            return 'password not matched with old password';
                          }
                          return null;
                        },
                        controller: oldPasswordController,
                        obsecureText: true,
                        prefix: "assets/svgs/lock.svg",
                        title: "Old password",
                        suffix: const Icon(Icons.visibility_off)),
                    getVerticalSpace(height: 3.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "New Password",
                        style: AppTextStyles.regularTextStyle,
                      ),
                    ),
                    getVerticalSpace(height: .5.h),
                    customTextFormField(
                        validator: (value) {
                          if (value!.isEmpty && value == '') {
                            return 'Please fill this field';
                          }

                          return null;
                        },
                        controller: newPasswordController,
                        obsecureText: true,
                        prefix: "assets/svgs/lock.svg",
                        title: "New password",
                        suffix: const Icon(Icons.visibility_off)),
                    getVerticalSpace(height: 3.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirm Password",
                        style: AppTextStyles.regularTextStyle,
                      ),
                    ),
                    getVerticalSpace(height: .5.h),
                    customTextFormField(
                        validator: (value) {
                          if (value!.isEmpty && value == '') {
                            return 'Please fill this field';
                          }
                          if (value != newPasswordController.text) {
                            return 'Please enter same password';
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                        obsecureText: true,
                        prefix: "assets/svgs/lock.svg",
                        title: "Confirm password",
                        suffix: const Icon(Icons.visibility_off)),
                    getVerticalSpace(height: 4.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customElevatedButton(width: mediaQuerySize.width * 0.43, title: 'Cancel', titleColor: AppColors.primaryColor, bgColor: Colors.transparent, borderColor: AppColors.primaryColor),
                          customElevatedButton(
                            loading: userController.isLoading.value,
                            onTap: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                await userController.updateData(users_collection, userController.userData.value?.uid ?? '', {'password': newPasswordController.text});
                              }
                            },
                            title: 'Change',
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
        ),
      );
    });
  }
}
