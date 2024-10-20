import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/getx_controllers/user_controller.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/controllers/utils/snackbar.dart';

import 'package:wave/views/custom_widgets/custom_widgets.dart';

import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late UserController userController;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    userController = Get.put(UserController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/pngs/sign_up.png"),
              getVerticalSpace(height: 2.h),
              Text(
                "Get started",
                style: AppTextStyles.boldTextStyle,
              ),
              getVerticalSpace(height: 1.h),
              Text(
                "Please enter the required details",
                style: AppTextStyles.regularTextStyle,
              ),
              getVerticalSpace(height: 3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: AppTextStyles.regularTextStyle,
                    ),
                    getVerticalSpace(height: .5.h),
                    customTextFormField(prefix: "assets/svgs/person.svg", title: "Lita han", controller: nameController),
                    getVerticalSpace(height: 2.h),
                    Text(
                      "Email",
                      style: AppTextStyles.regularTextStyle,
                    ),
                    getVerticalSpace(height: .5.h),
                    customTextFormField(prefix: "assets/svgs/email.svg", title: "Litahan@gmail.com", controller: emailController),
                    getVerticalSpace(height: 2.h),
                    Text(
                      "Password",
                      style: AppTextStyles.regularTextStyle,
                    ),
                    getVerticalSpace(height: .5.h),
                    customTextFormField(prefix: "assets/svgs/lock.svg", title: "***********", suffix: SvgPicture.asset("assets/svgs/eye_off.svg"), controller: passwordController),
                    getVerticalSpace(height: 2.h),
                    Text(
                      "Confirm Password",
                      style: AppTextStyles.regularTextStyle,
                    ),
                    getVerticalSpace(height: .5.h),
                    customTextFormField(prefix: "assets/svgs/lock.svg", title: "***********", suffix: SvgPicture.asset("assets/svgs/eye_off.svg"), controller: confirmPasswordController),
                    getVerticalSpace(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return customElevatedButton(
                                  height: 5.h,
                                  loading: userController.loading.value,
                                  onTap: () {
                                    if (validateSignup(name: nameController.text, email: emailController.text, password: passwordController.text, confirmPassword: confirmPasswordController.text)) {
                                      userController.signUpWithEmail(nameController.text, emailController.text, passwordController.text).then(
                                        (user) {
                                          if (user != null) {
                                            Get.to(() => const SignInScreen());
                                          }
                                        },
                                      );
                                    }
                                  },
                                  title: "Sign Up");
                            }),
                          ),
                        ],
                      ),
                    ),
                    getVerticalSpace(height: 3.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(text: 'Already have an account? ', style: AppTextStyles.regularTextStyle),
                          TextSpan(text: 'Sign In', style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.primaryColor)),
                        ])),
                      ),
                    ),
                    // getVerticalSpace(height: 1.h),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Text(
                    //       'Or',
                    //       style: AppTextStyles.regularTextStyle),
                    // ),
                    // getVerticalSpace(height: 1.h),
                    //
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validateSignup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    // Check if name is not empty
    if (name.isEmpty) {
      showErrorSnackbar("Name cannot be empty.");
      return false;
    }

    // Check if email is not empty and follows a simple email pattern
    final emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.isEmpty || !emailPattern.hasMatch(email)) {
      showErrorSnackbar("Invalid email address.");
      return false;
    }

    // Check if password is not empty and has minimum length
    if (password.isEmpty || password.length < 6) {
      showErrorSnackbar("Password must be at least 6 characters long.");
      return false;
    }

    // Check if confirm password matches the password
    if (confirmPassword != password) {
      showErrorSnackbar("Passwords do not match.");
      return false;
    }

    // If all validations pass
    return true;
  }
}
