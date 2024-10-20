import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart'; // Ensure correct import
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  final Rx<double> minAge = 0.0.obs;
  final Rx<double> maxAge = 100.0.obs;
  final Rx<double> startAge = 0.0.obs;
  final Rx<double> endAge = 100.0.obs;
  final RxList<String> statusList =
      ["Single", "Separated", "Divorced", "Widowed"].obs;
  final RxInt selectedIndex=0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(
                      "Filters",
                      style:
                          AppTextStyles.boldTextStyle.copyWith(fontSize: 16.px),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.3.h, vertical: .6.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.h),
                            color: AppColors.whiteColor,
                            border: Border.all(color: AppColors.primaryColor)),
                        child: Text(
                          "Clear All",
                          style: AppTextStyles.buttonTextStyle.copyWith(
                              color: AppColors.primaryColor, fontSize: 12.px),
                        ),
                      ),
                    ),
                  ],
                ),
                getVerticalSpace(height: 2.h),
                Container(
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.h), // Example radius
                    color: AppColors.lightGreyColor
                        .withOpacity(0.1), // Replace with your color
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 3.h,
                              width: 3.h,
                              child:
                                  SvgPicture.asset("assets/svgs/calender.svg")),
                          getHorizentalSpace(width: 1.6.h),
                          Text(
                            "Age",
                            style: AppTextStyles.regularLargeTextStyle,
                          )
                        ],
                      ),
                      getVerticalSpace(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "0y",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                                getHorizentalSpace(width: 2.7.h),
                                Text(
                                  "18y",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "50y",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                                getHorizentalSpace(width: 7.h),
                                Text(
                                  "100y",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => SfRangeSlider(
                          min: minAge.value,
                          max: maxAge.value,
                          values: SfRangeValues(startAge.value, endAge.value),
                          showTicks: false,
                          showLabels: false,
                          enableTooltip: false,
                          activeColor: AppColors.primaryColor,
                          inactiveColor: const Color(0xffC3C3C2),
                          onChanged: (SfRangeValues values) {
                            startAge.value = values.start;
                            endAge.value = values.end;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                getVerticalSpace(height: 1.h),
                Container(
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.h), // Example radius
                    color: AppColors.lightGreyColor
                        .withOpacity(0.1), // Replace with your color
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  height: 3.h,
                                  width: 3.h,
                                  child:
                                      SvgPicture.asset("assets/svgs/height.svg")),
                              getHorizentalSpace(width: 1.6.h),
                              Text(
                                "Height",
                                style: AppTextStyles.regularLargeTextStyle,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.h, vertical: .6.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1.5.h),
                                      color: AppColors.primaryColor,
                                      border: Border.all(
                                          color: AppColors.primaryColor)),
                                  child: Text(
                                    "Cm",
                                    style: AppTextStyles.buttonTextStyle.copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: 12.px),
                                  ),
                                ),
                              ),
                              getHorizentalSpace(width: 1.6.h),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.3.h, vertical: .6.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1.5.h),
                                      color: AppColors.whiteColor,
                                      border: Border.all(
                                          color: AppColors.primaryColor)),
                                  child: Text(
                                    "ft/ inch",
                                    style: AppTextStyles.buttonTextStyle.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 12.px),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      getVerticalSpace(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "0in",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                                getHorizentalSpace(width: 2.7.h),
                                Text(
                                  "5in",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "8in",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                                getHorizentalSpace(width: 7.h),
                                Text(
                                  "10in",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => SfRangeSlider(
                          min: minAge.value,
                          max: maxAge.value,
                          values: SfRangeValues(startAge.value, endAge.value),
                          showTicks: false,
                          showLabels: false,
                          enableTooltip: false,
                          activeColor: AppColors.primaryColor,
                          inactiveColor: const Color(0xffC3C3C2),
                          onChanged: (SfRangeValues values) {
                            startAge.value = values.start;
                            endAge.value = values.end;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                getVerticalSpace(height: 1.h),
                Container(
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.h), // Example radius
                    color: AppColors.lightGreyColor
                        .withOpacity(0.1), // Replace with your color
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 3.h,
                              width: 3.h,
                              child: SvgPicture.asset("assets/svgs/gender.svg")),
                          getHorizentalSpace(width: 1.6.h),
                          Text(
                            "Gender",
                            style: AppTextStyles.regularLargeTextStyle,
                          ),
                        ],
                      ),
                      getVerticalSpace(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.2.h, vertical: 1.h),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(1.4.h)),
                            child: Column(
                              children: [
                                SvgPicture.asset("assets/svgs/unselecticon.svg"),
                                Text(
                                  "Man",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                              ],
                            ),
                          ),
                          getHorizentalSpace(width: 2.h),
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.2.h, vertical: 1.h),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.primaryColor),
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(1.4.h)),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/svgs/selecticon.svg"),
                                    Text(
                                      "Man",
                                      style: AppTextStyles.regularTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: .5.h,
                                right: 1.h,
                                child: SizedBox(
                                    height: 2.h,
                                    width: 2.h,
                                    child:
                                        SvgPicture.asset("assets/svgs/tick.svg")),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                getVerticalSpace(height: 1.h),
                Container(
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.h), // Example radius
                    color: AppColors.lightGreyColor
                        .withOpacity(0.1), // Replace with your color
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 3.h,
                              width: 3.h,
                              child: SvgPicture.asset(
                                  "assets/svgs/relationship.svg")),
                          getHorizentalSpace(width: 1.6.h),
                          Text(
                            "Relationship Status",
                            style: AppTextStyles.regularLargeTextStyle,
                          ),
                        ],
                      ),
                      getVerticalSpace(height: 1.h),
                      SizedBox(
                        height: 10.h,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns
                                  crossAxisSpacing: 8.0, // Space between columns
            
                                  childAspectRatio: 2 / 0.5),
                          itemCount:
                              statusList.length, // Adjust item count if needed
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                selectedIndex.value=index;
                              },
                              child: Obx(() =>
                              Row(
                                  children: [
                                    SizedBox(
                                        height: 2.5.h,
                                        width: 2.5.h,
                                        child:    SvgPicture.asset(
                                            selectedIndex.value==index?"assets/svgs/selectedcircle.svg":"assets/svgs/unselectcircle.svg")),
                                    const SizedBox(
                                        width: 8.0), // Space between icon and text
                                    Text(
                                      statusList[index], // Example text
                                      style: AppTextStyles.regularLargeTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                getVerticalSpace(height: 1.h),
                Text(
                  "Location",
                  style: AppTextStyles.regularTextStyle,
                ),
                getVerticalSpace(height: .8.h),
                customTextField(
                    horizentalPadding: 2.h,
                    title: "LA"),
                getVerticalSpace(height: 3.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 1.5.h),
                  child: Row(children: [
                    Expanded(child: customElevatedButton(
                      title: "Cancel",
                      bgColor: AppColors.whiteColor,
                      titleColor: AppColors.primaryColor,
                      height: 5.h,

                    )),getHorizentalSpace(width: 2.h),
                    Expanded(child: customElevatedButton(
                        height: 5.h,

                        title: "Apply"
                    )),
                  ],),
                ),
                getVerticalSpace(height: 2.h)
              ],
            ),
          ),
        ),
      ),
    );
  }


}
