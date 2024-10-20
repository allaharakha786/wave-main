import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/views/custom_widgets/custom_list_tile.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

import 'contact_us_screen.dart';

// ignore: must_be_immutable
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Report A Problem'),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child:
                            SvgPicture.asset('assets/svgs/privacy_image.svg')),
                    getVerticalSpace(height: 3.h),
                    const Text(
                      '1. Types data we collect',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    getVerticalSpace(height: 1.h),
                    const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '),
                    getVerticalSpace(height: 3.h),
                    const Text(
                      '2. Use of your personal data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    getVerticalSpace(height: 1.h),
                    const Text(
                        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae.'),
                    getVerticalSpace(height: 3.h),
                    const Text(
                      '3. Disclosure of your personal data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    getVerticalSpace(height: 1.h),
                    const Text(
                        "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium"),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
