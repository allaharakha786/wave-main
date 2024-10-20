import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/auth_section/sign_in_screen.dart';
import 'package:wave/views/screens/auth_section/sign_up_screen.dart';
import 'package:wave/views/screens/on_boarding_section/on_boarding_first_screen.dart';

import 'on_board_four.dart';
import 'on_board_second.dart';
import 'on_board_third.dart';

class OnboardingTabs extends StatefulWidget {
  const OnboardingTabs({super.key});

  @override
  OnboardingTabsState createState() => OnboardingTabsState();
}

class OnboardingTabsState extends State<OnboardingTabs> {
  final PageController controller =
      PageController(keepPage: true);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void nextPage() {
    int currentPage = controller.page?.toInt() ?? 0;
    if (currentPage < 3) { // Assuming you have 4 pages (0, 1, 2, 3)
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to SignUpScreen and clear the entire stack
      Get.offAll(() => const SignInScreen());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  children: const [
                    OnBoardingFirstScreen(),
                    OnBoardingSecond(),
                    OnBoardingThird(),
                    OnBoardingFour(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.6.h),
                child: Row(children: [
                  Container(
                    height: 6.h,
                    width: 16.h,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(3.h)),
                    child: ElevatedButton(
                        onPressed: () {
                          nextPage();
                        },
                        style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(
                                AppColors.primaryColor),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.h)))),
                        child: Text(
                          "Next",
                          style: AppTextStyles.buttonTextStyle,
                        )),
                  ),
                  const Expanded(child: SizedBox()),
                  getHorizentalSpace(width: 13.h),
                  SmoothPageIndicator(
                      controller: controller,
                      count: 4,
                      effect: ExpandingDotsEffect(
                          dotHeight: 1.2.h,
                          dotWidth: 1.2.h,
                          activeDotColor: AppColors.primaryColor,
                          dotColor: AppColors.lightGreyColor)),
                ]),
              ),
              getVerticalSpace(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
