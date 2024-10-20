import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/profile_section/interests_and_hobbies.dart';

class LearningLanguage extends StatefulWidget {
  final String language;
  final int level;
  const LearningLanguage({super.key, required this.language, required this.level});

  @override
  State<LearningLanguage> createState() =>
      _LearningLanguageState();
}

class _LearningLanguageState
    extends State<LearningLanguage> {
  final TextEditingController searchController = TextEditingController();

  RxList<String> titles = [
    "Connect with people",
    "Prepare for travel",
    "Boost my career",
    "Support my education",
    "Just for fun",
    "Spend time productively"
  ].obs;

  RxList<String> images = [
    "assets/svgs/people.svg",
    "assets/svgs/travel.svg",
    "assets/svgs/boost.svg",
    "assets/svgs/support.svg",
    "assets/svgs/fun.svg",
    "assets/svgs/spend.svg",

  ].obs;
  final RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            getVerticalSpace(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SizedBox(
                        height: 3.5.h,
                        width: 3.5.h,
                        child: SvgPicture.asset(
                          "assets/svgs/arrow_back.svg",
                          fit: BoxFit.cover,
                        )),
                  ),
                  const Expanded(child: SizedBox()),
                  Text("Why are you learning ${widget.language}?",
                      style: AppTextStyles.onBoardingTextStyle),
                  getHorizentalSpace(width: 1.h),
                  const Expanded(child: SizedBox())
                ],
              ),
            ),
            getVerticalSpace(height: 3.h),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return Obx(
                        () => GestureDetector(
                      onTap: () {
                        selectedIndex.value=index;
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 3.h,
                          vertical: 1.h, // Adjust vertical spacing between items
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.h,
                          vertical: 2.h, // Adjust vertical spacing between items
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.15),
                              offset: const Offset(2, 2),
                              spreadRadius: 0,
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(images[index]),
                                getHorizentalSpace(width: 1.h),
                                Text(titles[index],
                                  style: AppTextStyles.regularTextStyle,)
                              ],
                            ),
                            SizedBox(
                              height: 2.3.h,
                              width: 2.4.h,
                              child: SvgPicture.asset(
                                selectedIndex.value == index
                                    ? "assets/svgs/select.svg"
                                    : "assets/svgs/unselect.svg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.6.h),
              child: Row(
                children: [
                  Expanded(
                    child: customElevatedButton(
                      height: 5.h,
                      onTap: () {
                        Get.to(() => InterestsAndHobbies(language: widget.language, level: widget.level, reason: titles[selectedIndex.value],));
                      },
                      title: "Continue",
                    ),
                  ),
                ],
              ),
            ),
            getVerticalSpace(height: 2.h)
          ],
        ),
      ),
    );
  }
}
