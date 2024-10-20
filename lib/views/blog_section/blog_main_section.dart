import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class BlogsMainScreen extends StatelessWidget {
  BlogsMainScreen({super.key});
  final RxList<String> titleList =
      ["All", "Technology", "Lifestyle", "Business", "Culture", "Event"].obs;
  final RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.6.h),
          child: Column(
            children: [
              getVerticalSpace(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Blogs",
                    style:
                        AppTextStyles.boldTextStyle.copyWith(fontSize: 16.px),
                  ),
                ],
              ),
              getVerticalSpace(height: 2.h),
              customTextFormField(
                title: "Search",
                prefix: "assets/svgs/search.svg",
                prefixSize: 0.04.h,
              ),
              getVerticalSpace(height: 2.h),
              SizedBox(
                height: 4.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: titleList.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          selectedIndex.value = index;
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: .6.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: .9.h, vertical: .8.h),
                          decoration: BoxDecoration(
                              color: selectedIndex.value == index
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColor.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(3.h)),
                          child: Text(
                            titleList[index],
                            style: AppTextStyles.regularTextStyle.copyWith(
                                fontSize: 10.px,
                                color: selectedIndex.value == index
                                    ? AppColors.whiteColor
                                    : AppColors.primaryColor),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              getVerticalSpace(height: 2.8.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: .5.h, vertical: .8.h),
                        decoration: BoxDecoration(
                            color: AppColors.lightGreyColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(1.5.h)),
                        child: Row(children: [
                          Container(
                            height: 9.h,
                            width: 10.3.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.h),
                                image: const DecorationImage(
                                    image:
                                        AssetImage("assets/pngs/vlogs.png"))),
                          ),
                          getHorizentalSpace(width: 1.4.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Technology",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color: AppColors.primaryColor),
                                  ),
                                  getHorizentalSpace(width: 10.h),
                                  Text(
                                    "Jan 4, 2022",
                                    style: AppTextStyles.regularTextStyle,
                                  ),
                                ],
                              ),
                              getVerticalSpace(height: 1.h),
                              Text(
                                "Augmented Reality Trends\n for 2022",
                                style: AppTextStyles.regularLargeTextStyle,
                              )
                            ],
                          ),
                        ]));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
