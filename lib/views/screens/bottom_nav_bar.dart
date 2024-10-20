import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/blog_section/blog_main_section.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/meet_section/meet_home_screen.dart';
import 'package:wave/views/screens/chat_section/chat_tab_bar.dart';

import 'home_section/home_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({super.key});
  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              selectedIndex.value == 0
                  ? const Expanded(child: HomeScreen())
                  : selectedIndex.value == 1
                      ? const Expanded(child: MeetHomeScreen())
                      : selectedIndex.value == 2
                          ? const Expanded(child: ChatTabBar())
                          :  Expanded(
                              child: BlogsMainScreen()),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 2.h),
                  decoration:
                      BoxDecoration(color: AppColors.whiteColor, boxShadow: [
                    BoxShadow(
                        color: const Color(0xff000014).withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: const Offset(1, 1))
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectedIndex.value = 0;
                        },
                        child: Container(
                          child: selectedIndex.value == 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Home",
                                      style: AppTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 14.px,
                                              fontWeight: FontWeight.w400),
                                    ),
                                    getVerticalSpace(height: .8.h),
                                    SvgPicture.asset("assets/svgs/focus.svg"),
                                  ],
                                )
                              : SvgPicture.asset("assets/svgs/home.svg"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedIndex.value = 1;
                        },
                        child: Container(
                          child: selectedIndex.value == 1
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Meet",
                                      style: AppTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 14.px,
                                              fontWeight: FontWeight.w400),
                                    ),
                                    getVerticalSpace(height: .8.h),
                                    SvgPicture.asset("assets/svgs/focus.svg"),
                                  ],
                                )
                              : SvgPicture.asset("assets/svgs/heart.svg"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedIndex.value = 2;
                        },
                        child: Container(
                          child: selectedIndex.value == 2
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Chat",
                                      style: AppTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 14.px,
                                              fontWeight: FontWeight.w400),
                                    ),
                                    getVerticalSpace(height: .8.h),
                                    SvgPicture.asset("assets/svgs/focus.svg"),
                                  ],
                                )
                              : SvgPicture.asset("assets/svgs/chat.svg"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedIndex.value = 3;
                        },
                        child: Container(
                          child: selectedIndex.value == 3
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Blogs",
                                      style: AppTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 14.px,
                                              fontWeight: FontWeight.w400),
                                    ),
                                    getVerticalSpace(height: .8.h),
                                    SvgPicture.asset("assets/svgs/focus.svg"),
                                  ],
                                )
                              : SvgPicture.asset("assets/svgs/books.svg"),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
