import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/profile_section/learning_language.dart';

class FresherScreen extends StatelessWidget {
  final String language;
  final int level;

  const FresherScreen({super.key, required this.language, required this.level});

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
                image: AssetImage("assets/pngs/rocket.png"),
                fit: BoxFit.cover,
              ),
              getVerticalSpace(height: 3.h),
              Text(
                "Okay we’ll start fresh",
                style: AppTextStyles.regularLargeTextStyle,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: customElevatedButton(
                        height: 5.h,
                        onTap: () {
                          Get.to(() => LearningLanguage(
                                level: level,
                                language: language,
                              ));
                        },
                        title: "Continue"),
                  ),
                ],
              ),
              getVerticalSpace(height: 2.h)
            ],
          ),
        ),
      ),
    );
  }
}
