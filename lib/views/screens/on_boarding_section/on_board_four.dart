import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class OnBoardingFour extends StatelessWidget {
  const OnBoardingFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Image(
              image: AssetImage("assets/pngs/onboardtfour.png"),
              fit: BoxFit.cover,
            ),
            getVerticalSpace(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Discover, Connect, and Grow Through Language Learning.",
                    style: AppTextStyles.onBoardingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  getVerticalSpace(height: 8.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
