import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../views/custom_widgets/custom_widgets.dart';
import 'app_colors.dart';

void showCommonModalBottomSheet({
  required BuildContext context,
  required String iconPath,
  required String title,
  required String description,
  required String button1Text,
  required String button2Text,
  required VoidCallback button1Callback,
  required VoidCallback button2Callback,
  bool? loading,
}) {
  final mediaQuerySize = MediaQuery.of(context).size;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      return Container(
        width: mediaQuerySize.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconPath,width: 80.px, height: 80.px),
            SizedBox(height: 1.7.h),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            SizedBox(height: 1.7.h),
            Text(
              description,
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: customElevatedButton(
                    title: button1Text,
                    onTap: button1Callback,
                    bgColor: AppColors.whiteColor,
                    titleColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    height: 6.h,
                    width: mediaQuerySize.width * 0.4,
                    radius: 15.px,
                    loading: loading,
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: customElevatedButton(
                    title: button2Text,
                    onTap: button2Callback,
                    bgColor: AppColors.primaryColor,
                    titleColor: AppColors.whiteColor,
                    height: 6.h,
                    width: mediaQuerySize.width * 0.4,
                    radius: 15.px,
                    loading: loading,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
