import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';

Widget getVerticalSpace({required double height}) {
  return SizedBox(
    height: height,
  );
}

Widget getHorizentalSpace({required double width}) {
  return SizedBox(
    width: width,
  );
}

Widget customTextFormField({
  TextEditingController? controller,
  String? title,
  Callback? onTap,
  bool? obsecureText,
  bool? readOnly,
  TextInputType? keyBoardType,
  int? maxLine,
  Color? bgColor,
  Color? borderColor,
  String? prefix,
  String? prefixWidget,
  bool? isPrefix,
  Widget? suffix,
  Widget? lineImage,
  double? width,
  double? prefixSize,
  double? horizentalPadding,
  double? verticalPadding,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    readOnly: readOnly ?? false,
    obscureText: obsecureText ?? false,
    keyboardType: keyBoardType,
    maxLines: maxLine ?? 1,
    cursorColor: AppColors.primaryColor,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3.h),
      ),
      hintText: title ?? 'Email',
      hintStyle: AppTextStyles.hintTextStyle,
      filled: true,
      fillColor: bgColor ?? AppColors.textFieldBackgroundColor,
      isCollapsed: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3.h),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(3.h), borderSide: const BorderSide(color: Colors.transparent)),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizentalPadding ?? 1.h,
        vertical: verticalPadding ?? 1.3.h,
      ),
      prefixIcon: isPrefix ?? true
          ? Transform.scale(
              scale: prefixSize ?? 0.06.h,
              child: SvgPicture.asset(
                prefix ?? 'assets/svgs/person.svg',
              ),
            )
          : null,
      suffixIcon: Transform.scale(scale: 0.06.h, child: suffix),
    ),
  );
}

typedef Callback = void Function();

Widget customTextField({
  TextEditingController? controller,
  String? title,
  Callback? onTap,
  bool? readOnly,
  TextInputType? keyBoardType,
  int? maxLine,
  Color? bgColor,
  Color? borderColor,
  Widget? suffix,
  Widget? prefix,
  double? horizentalPadding,
  double? verticalPadding,
  double? borderRadius,
  Function(String)? onChanged, // Added onChanged parameter
}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly ?? false,
    keyboardType: keyBoardType,
    maxLines: maxLine ?? 1,
    cursorColor: AppColors.primaryColor,
    onChanged: onChanged,
    // Pass the onChanged callback to TextFormField
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 30.px),
      ),
      hintText: title ?? 'Email',
      hintStyle: AppTextStyles.hintTextStyle,
      filled: true,
      fillColor: bgColor ?? AppColors.textFieldBackgroundColor,
      isCollapsed: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 3.h),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 3.h),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizentalPadding ?? 0.h,
        vertical: verticalPadding ?? 1.3.h,
      ),
      prefixIcon: prefix,
      suffixIcon: suffix,
    ),
  );
}

Widget customElevatedButton({
  double? radius,
  double? fontSize,
  Callback? onTap,
  String? title,
  double? height,
  double? width,
  Color? bgColor,
  Color? titleColor,
  Color? borderColor,
  bool? loading,
}) {
  return Container(
    height: height ?? 6.h,
    width: width ?? 16.h,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? 3.h)),
    child: ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bgColor ?? AppColors.primaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? AppColors.primaryColor),
            borderRadius: BorderRadius.circular(radius ?? 3.h),
          ),
        ),
      ),
      child: loading == true
          ? LoadingAnimationWidget.prograssiveDots(color: Colors.white, size: 30.px)
          : Text(
              overflow: TextOverflow.ellipsis,
              title ?? "Next",
              style: fontSize == 1 ? const TextStyle(fontSize: 14) : AppTextStyles.buttonTextStyle.copyWith(color: titleColor ?? AppColors.whiteColor),
            ),
    ),
  );
}
