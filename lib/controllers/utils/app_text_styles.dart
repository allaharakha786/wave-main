import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle boldTextStyleSplash = TextStyle(
    fontSize: 40.px,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w400,
    fontFamily: "limelight",
  );
  static TextStyle onBoardingTextStyle = TextStyle(
    fontSize: 18.px,
    color: AppColors.secondaryColor,
    fontWeight: FontWeight.w400,
    fontFamily: "poppins",
  );
  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 17.px,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w400,
    fontFamily: "poppins",
  );
  static TextStyle hintTextStyle = TextStyle(
    fontSize: 10.px,
    color: AppColors.hintColor,
    fontWeight: FontWeight.w400,
    fontFamily: "poppins",
  );
  static TextStyle boldTextStyle = TextStyle(
    fontSize: 22.px,
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontFamily: "poppins",
  );
  static TextStyle regularTextStyle = TextStyle(
    fontSize: 12.px,
    color: AppColors.hintColor,
    fontWeight: FontWeight.w300,
    fontFamily: "poppins",
  );
  static TextStyle regularLargeTextStyle = TextStyle(
    fontSize: 15.px,
    color: AppColors.hintColor,
    fontWeight: FontWeight.w300,
    fontFamily: "poppins",
  );
}
