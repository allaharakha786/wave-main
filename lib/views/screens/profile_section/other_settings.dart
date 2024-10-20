import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/views/custom_widgets/custom_list_tile.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/home_section/share_screen.dart';
import 'package:wave/views/screens/profile_section/privacy_policy.dart';
import 'package:wave/views/screens/profile_section/share_screen.dart';

import 'contact_us_screen.dart';

// ignore: must_be_immutable
class OtherSettingScreen extends StatelessWidget {
  const OtherSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Other Settings'),
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
                CustomListTile(
                  onTap: () {
                    Get.to(() => const ContactUsScreen());
                  },
                  leadingIcon: 'assets/svgs/email.svg',
                  title: 'Contact us',
                  trailingIcon: false,
                  subtitle: '',
                ),
                getVerticalSpace(height: 3.h),
                CustomListTile(
                  onTap: () {
                    Get.to(() => const PrivacyPolicyScreen());
                  },
                  leadingIcon: 'assets/svgs/privacy_icon.svg',
                  title: 'Privacy Policy',
                  trailingIcon: false,
                  subtitle: '',
                ),
                getVerticalSpace(height: 3.h),
                CustomListTile(
                  onTap: () {
                    Get.to(() => ShareAndInviteScreen());
                  },
                  leadingIcon: 'assets/svgs/share_icon.svg',
                  title: 'Share & Invite Friends',
                  trailingIcon: false,
                  subtitle: '',
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
