import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/views/custom_widgets/custom_list_tile.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/profile_section/privacy_policy.dart';

import 'contact_us_screen.dart';

// ignore: must_be_immutable
class ShareAndInviteScreen extends StatelessWidget {
  ShareAndInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Share & Invite Friends'),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: mediaQuerySize.width * 0.02),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GestureDetector(
        child: SizedBox(
          width: mediaQuerySize.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
              child: Column(children: [
                SvgPicture.asset('assets/svgs/share_image.svg'),
                getVerticalSpace(height: 4.h),
                const Text(
                  'Invite your Friends',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                getVerticalSpace(height: 3.h),
                const Text(
                  'Because your friends deserve to\n Live a Better Life',
                  textAlign: TextAlign.center,
                ),
                getVerticalSpace(height: 4.h),
                Text(
                  'Copy Invite Link',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                getVerticalSpace(height: 1.5.h),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaQuerySize.width * 0.01,
                      vertical: mediaQuerySize.height * 0.01),
                  width: mediaQuerySize.width * 0.5,
                  decoration: BoxDecoration(
                      color: AppColors.blackColor.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('VhoWIHVhoWIH'),
                      SizedBox(
                        width: mediaQuerySize.width * 0.03,
                      ),
                      SvgPicture.asset('assets/svgs/share_image_2.svg')
                    ],
                  ),
                ),
                getVerticalSpace(height: 4.h),
                Text(
                  'SHARE BY USING',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                getVerticalSpace(height: 1.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    shareImages.length,
                    (index) {
                      return SvgPicture.asset(shareImages[index]);
                    },
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  List<String> shareImages = [
    'assets/svgs/message_icon.svg',
    'assets/svgs/email_image.svg',
    'assets/svgs/messenger_image.svg',
    'assets/svgs/whatsapp_image.svg',
    'assets/svgs/twitter_image.svg',
  ];
}
