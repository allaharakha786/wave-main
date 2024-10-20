import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class ShareScreen extends StatelessWidget {
  ShareScreen({super.key});
  final RxList<String> imageList = <String>[
    "assets/pngs/userone.png",
    "assets/pngs/usertwo.png",
    "assets/pngs/userthree.png",
    "assets/pngs/userone.png",
    "assets/pngs/usertwo.png",
    "assets/pngs/userthree.png",
    "assets/pngs/userone.png",
    "assets/pngs/usertwo.png",
    "assets/pngs/userthree.png",
    "assets/pngs/userone.png"
  ].obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getVerticalSpace(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  const Expanded(child: SizedBox()),
                  Text(
                    "Share",
                    style:
                        AppTextStyles.boldTextStyle.copyWith(fontSize: 16.px),
                  ),
                  getHorizentalSpace(width: 4.h),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            getVerticalSpace(height: 3.h),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(imageList[index]),
                              radius: 3.h,
                            ),
                            getHorizentalSpace(width: 1.3.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Lita Han",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(color: AppColors.blackColor)),
                                getVerticalSpace(height: .5.h),
                                Text(
                                  "Lorem ipsum dolor",
                                  style: AppTextStyles.regularTextStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      getVerticalSpace(height: 1.2.h),
                      const Divider(
                        color: AppColors.lightGreyColor,
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
