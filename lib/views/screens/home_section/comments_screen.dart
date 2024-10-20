import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key});
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
                    "Comments",
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
              child: Stack(
                children: [
                  ListView.builder(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(imageList[index]),
                                  radius: 3.h,
                                ),
                                getHorizentalSpace(width: 1.3.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'karennne ',
                                          style: AppTextStyles.regularTextStyle
                                              .copyWith(
                                                  color: AppColors.blackColor)),
                                      TextSpan(
                                          text: ' 16m',
                                          style:
                                              AppTextStyles.regularTextStyle),
                                    ])),
                                    getVerticalSpace(height: .5.h),
                                    Text(
                                      "Lorem ipsum dolor",
                                      style: AppTextStyles.regularTextStyle,
                                    ),
                                    getVerticalSpace(height: .5.h),
                                    Text(
                                      "Reply",
                                      style: AppTextStyles.regularTextStyle,
                                    )
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.4.h, vertical: 2.1.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: customTextField(
                                borderRadius: 1.5.h,
                                horizentalPadding: 2.h,
                                title: "Add a comment..."),
                          ),
                          getHorizentalSpace(width: 1.h),
                          SizedBox(
                              height: 5.h,
                              width: 5.h,
                              child: Image.asset("assets/pngs/sendmessage.png"))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
