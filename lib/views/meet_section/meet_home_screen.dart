import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/meet_section/filter_screen.dart';
import 'package:wave/views/meet_section/meet_detail_screen.dart';

class MeetHomeScreen extends StatelessWidget {
  const MeetHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Column(
            children: [
              getVerticalSpace(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: SizedBox()),
                  Text(
                    "Meet",
                    style:
                        AppTextStyles.boldTextStyle.copyWith(fontSize: 16.px),
                  ),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => FilterScreen());
                    },
                    child: SizedBox(
                        height: 4.h,
                        width: 4.h,
                        child: SvgPicture.asset("assets/svgs/filtericon.svg")),
                  ),
                ],
              ),
              getVerticalSpace(height: 2.2.h),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 2 / 3),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const MeetDetailScreen());
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(2.h), // Example radius
                              color: AppColors
                                  .lightGreyColor, // Replace with your color
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/pngs/meetbgimage.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(2.h),
                                  bottomLeft: Radius.circular(2.h),
                                ), // Example radius
                                color: AppColors.whiteColor.withOpacity(
                                    0.34), // Replace with your color
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sophie",
                                        style: AppTextStyles
                                            .regularLargeTextStyle
                                            .copyWith(
                                                color: AppColors.whiteColor),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Irish",
                                            style: TextStyle(
                                                color: AppColors.whiteColor),
                                          ),
                                          getHorizentalSpace(width: .5.h),
                                          SvgPicture.asset(
                                              "assets/svgs/exghangearrows.svg"),
                                          getHorizentalSpace(width: .5.h),
                                          const Text("German",
                                              style: TextStyle(
                                                  color: AppColors.whiteColor))
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: 1.8.h,
                                      child: const Image(
                                          image: AssetImage(
                                              "assets/pngs/hand.png"))),
                                  Text(
                                    "Say Hi",
                                    style: TextStyle(
                                        fontSize: 12.px,
                                        color: AppColors.whiteColor),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
