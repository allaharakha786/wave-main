import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/getx_controllers/user_controller.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/auth_section/forget_password_screen.dart';
import 'package:wave/views/screens/auth_section/sign_up_screen.dart';
import 'package:wave/views/screens/home_section/home_screen.dart';
import 'package:wave/views/screens/profile_section/ready_for_questions.dart';

import '../../../controllers/utils/snackbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late UserController userController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              getVerticalSpace(height: 1.h),
              Text(
                "Welcome back",
                style: AppTextStyles.boldTextStyle,
              ),
              getVerticalSpace(height: 1.h),
              Text(
                "Please enter the required details",
                style: AppTextStyles.regularTextStyle,
              ),
              getVerticalSpace(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    customTextFormField(prefix: "assets/svgs/lock.svg", title: "***********", controller: passwordController),
                    getVerticalSpace(height: 1.h),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const ForgotPassword(),
                            );
                          },
                          child: Text(
                            "Forgot Password",
                            style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.primaryColor),
                          ),
                        )),

                    getVerticalSpace(height: 3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return customElevatedButton(
                                  height: 5.h,
                                  loading: userController.loading.value,
                                  onTap: () async {
                                    if (validateLogin(email: emailController.text, password: passwordController.text)) {
                                      await userController.loginWithEmail(emailController.text, passwordController.text).then((result) {
                                        result.fold(
                                          (metaDataAdded) {
                                            Get.to(const ReadyForQuestions());
                                          },
                                          (user) {
                                            if (user != null) {
                                              Get.to(const HomeScreen());
                                            }
                                          },
                                        );
                                      });
                                    }
                                  },
                                  title: "Sign In");
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
                          Get.to(const SignUpScreen());
                        },
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(text: 'Don’t have an account?', style: AppTextStyles.regularTextStyle),
                          TextSpan(text: " Sign Up", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.primaryColor)),
                        ])),
                      ),
                    ),
                    getVerticalSpace(height: 1.h),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Text(
                    //       'Or',
                    //       style: AppTextStyles.regularTextStyle),
                    // ),
                    // getVerticalSpace(height: 1.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validateLogin({
    required String email,
    required String password,
  }) {
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

    // If all validations pass
    return true;
  }
}
