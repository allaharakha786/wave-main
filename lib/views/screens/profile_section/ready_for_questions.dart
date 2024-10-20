import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/profile_section/select_your_language.dart';

class ReadyForQuestions extends StatelessWidget {
  const ReadyForQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getVerticalSpace(height: 16.h),
              const Image(
                image: AssetImage("assets/pngs/emptyprofile.png"),
                fit: BoxFit.cover,
              ),
              getVerticalSpace(height: 3.h),
              Text(
                "Just few quick questions before we start your first lesson!",
                style: AppTextStyles.regularLargeTextStyle,
                textAlign: TextAlign.center,
              ),
              getVerticalSpace(height: 4.h),
              Row(
                children: [
                  Expanded(
                    child: customElevatedButton(
                        height: 5.h,
                        onTap: () {
                          Get.to(() => SelectYourLanguage(
                                screenName: '',
                              ));
                        },
                        title: "Continue"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
