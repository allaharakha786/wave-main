import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/getx_controllers/user_controller.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/controllers/utils/snackbar.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late UserController userController;
  TextEditingController emailController = TextEditingController();
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
              getVerticalSpace(height: 4.h),
              SizedBox(
                  height: 29.h,
                  child: Image.asset(
                    "assets/pngs/forgot.png",
                    fit: BoxFit.cover,
                  )),
              getVerticalSpace(height: 6.2.h),
              Text(
                "Forgot Password",
                style: AppTextStyles.boldTextStyle,
              ),
              getVerticalSpace(height: 1.h),
              Text(
                "Please enter your registered email Address",
                style: AppTextStyles.regularTextStyle,
              ),
              getVerticalSpace(height: 4.h),
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
                    customTextFormField(
                        prefix: "assets/svgs/email.svg",
                        title: "Litahan@gmail.com",
                    controller: emailController),
                    getVerticalSpace(height: 3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: customElevatedButton(
                              loading: userController.loading.value,
                                height: 5.h,
                                onTap: () {
                                  if(emailController.text.isNotEmpty)
                                    {
                                      userController.sendPasswordResetEmail(emailController.text).then((value) {
                                        if(value)
                                          {
                                            Get.back();
                                          }
                                      },);
                                    }
                                  else
                                    {
                                      showErrorSnackbar("Email cannot be empty");
                                    }
                                },
                                title: "Done"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
