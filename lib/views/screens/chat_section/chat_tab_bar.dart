import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class ChatTabBar extends StatelessWidget {
  const ChatTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                          child:
                              SvgPicture.asset("assets/svgs/arrow_back.svg")),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      "Chat",
                      style:
                          AppTextStyles.boldTextStyle.copyWith(fontSize: 16.px),
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),
                TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 6.h),
                    indicatorColor: AppColors.primaryColor,
                    labelStyle: AppTextStyles.regularTextStyle,
                    automaticIndicatorColorAdjustment: true,
                    labelColor: AppColors.primaryColor,
                    indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 2)),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(
                        child: Text(
                          "All Chats",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "My Chats",
                        ),
                      ),
                    ]),
                getVerticalSpace(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.6.h),
                  child: customTextFormField(
                    title: "Search",
                    prefix: "assets/svgs/search.svg",
                    prefixSize: 0.04.h,
                  ),
                ),
                getVerticalSpace(height: 1.h),
              Expanded(
                child: TabBarView(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.8.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          getVerticalSpace(height: 2.h),
                          ListView.builder(
                            itemCount: 7,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  padding: EdgeInsets.all(.8.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.lightGreyColor
                                          .withOpacity(0.1),
                                      borderRadius:
                                      BorderRadius.circular(1.5.h)),
                                  child: Row(children: [
                                    CircleAvatar(
                                      radius: 3.h,
                                      backgroundImage: const AssetImage(
                                          "assets/pngs/user.png"),
                                    ),
                                    getHorizentalSpace(width: 1.h),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Shia Rayy",
                                          style: AppTextStyles
                                              .regularLargeTextStyle
                                              .copyWith(
                                              color: AppColors.blackColor),
                                        ),
                                        getVerticalSpace(height: .6.h),
                                        Text(
                                          "Good morning, did you sleep well?",
                                          style: AppTextStyles.regularTextStyle,
                                        ),
                                      ],
                                    )
                                  ]));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.8.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          getVerticalSpace(height: 2.h),
                          ListView.builder(
                            itemCount: 7,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  padding: EdgeInsets.all(.8.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.lightGreyColor
                                          .withOpacity(0.1),
                                      borderRadius:
                                      BorderRadius.circular(1.5.h)),
                                  child: Row(children: [
                                    CircleAvatar(
                                      radius: 3.h,
                                      backgroundImage: const AssetImage(
                                          "assets/pngs/user.png"),
                                    ),
                                    getHorizentalSpace(width: 1.h),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Shia Rayy",
                                          style: AppTextStyles
                                              .regularLargeTextStyle
                                              .copyWith(
                                              color: AppColors.blackColor),
                                        ),
                                        getVerticalSpace(height: .6.h),
                                        Text(
                                          "Good morning, did you sleep well?",
                                          style: AppTextStyles.regularTextStyle,
                                        ),
                                      ],
                                    )
                                  ]));
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
