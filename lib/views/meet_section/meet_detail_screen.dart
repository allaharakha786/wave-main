import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class MeetDetailScreen extends StatelessWidget {
  const MeetDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerticalSpace(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SizedBox(
                        height: 4.h,
                        width: 4.h,
                        child: SvgPicture.asset("assets/svgs/arrow_back.svg")),
                  ),
                ],
              ),
              getVerticalSpace(height: 2.h),
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h), // Example radius
                  color: AppColors.lightGreyColor, // Replace with your color
                  image: const DecorationImage(
                    image: AssetImage("assets/pngs/meetbgimage.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              getVerticalSpace(height: 1.4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "John Parker",
                    style: AppTextStyles.buttonTextStyle
                        .copyWith(color: AppColors.blackColor, fontSize: 16.px),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 2.5.h,
                          child: const Image(
                              image: AssetImage("assets/pngs/hand.png"))),
                      getHorizentalSpace(width: 1.h),
                      Text(
                        "Say Hi",
                        style: TextStyle(
                            fontSize: 13.px, color: AppColors.blackColor),
                      )
                    ],
                  ),
                ],
              ),
              getVerticalSpace(height: 1.8.h),
              Text(
                "Country",
                style: AppTextStyles.regularLargeTextStyle
                    .copyWith(color: AppColors.blackColor),
              ),
              Text("Ireland", style: AppTextStyles.regularLargeTextStyle),
              getVerticalSpace(height: 1.8.h),
              Text(
                "Your Occupation",
                style: AppTextStyles.regularLargeTextStyle
                    .copyWith(color: AppColors.blackColor),
              ),
              Text("UI/UX Designer",
                  style: AppTextStyles.regularLargeTextStyle),
              getVerticalSpace(height: 1.8.h),
              Text(
                "Zodiac",
                style: AppTextStyles.regularLargeTextStyle
                    .copyWith(color: AppColors.blackColor),
              ),
              Text("Libra", style: AppTextStyles.regularLargeTextStyle),
              getVerticalSpace(height: 1.8.h),
              Text(
                "Learning",
                style: AppTextStyles.regularLargeTextStyle
                    .copyWith(color: AppColors.blackColor),
              ),
              Text("German",
                  style: AppTextStyles.regularLargeTextStyle
                      .copyWith(color: AppColors.primaryColor)),
              getVerticalSpace(height: 2.h),
              Text(
                "Bio",
                style: AppTextStyles.regularLargeTextStyle
                    .copyWith(color: AppColors.blackColor),
              ),
              Text(
                  "My name is John Parker and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading",
                  style: AppTextStyles.regularLargeTextStyle),
              getVerticalSpace(height: 1.5.h),
              Text("Interests", style: AppTextStyles.regularLargeTextStyle),
              getVerticalSpace(height: 1.4.h),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.h),
                        color: AppColors.primaryColor.withOpacity(0.34),
                        border: Border.all(color: AppColors.primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svgs/doubleclick.svg"),
                        Text(
                          "Travelling",
                          style: AppTextStyles.buttonTextStyle.copyWith(
                              color: AppColors.primaryColor, fontSize: 12.px),
                        )
                      ],
                    ),
                  ),
                  getHorizentalSpace(width: 1.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.h),
                        color: AppColors.primaryColor.withOpacity(0.34),
                        border: Border.all(color: AppColors.primaryColor)),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svgs/doubleclick.svg"),
                        Text(
                          "Books",
                          style: AppTextStyles.buttonTextStyle.copyWith(
                              color: AppColors.primaryColor, fontSize: 12.px),
                        )
                      ],
                    ),
                  ),
                  getHorizentalSpace(width: 1.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.h),
                        color: AppColors.primaryColor.withOpacity(0.34),
                        border: Border.all(color: AppColors.primaryColor)),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svgs/doubleclick.svg"),
                        Text(
                          "Music",
                          style: AppTextStyles.buttonTextStyle.copyWith(
                              color: AppColors.primaryColor, fontSize: 12.px),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
