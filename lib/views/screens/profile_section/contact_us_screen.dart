import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Contact Us'),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: Column(children: [
                SvgPicture.asset('assets/svgs/message_image.svg'),
                getVerticalSpace(height: 4.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: AppTextStyles.regularTextStyle,
                  ),
                ),
                getVerticalSpace(height: .5.h),
                customTextFormField(
                    prefix: "assets/svgs/person.svg", title: "Lita han"),
                getVerticalSpace(height: 3.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: AppTextStyles.regularTextStyle,
                  ),
                ),
                getVerticalSpace(height: .5.h),
                customTextFormField(
                    prefix: "assets/svgs/email.svg",
                    title: "Litahan@gmail.com"),
                getVerticalSpace(height: 3.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Message",
                    style: AppTextStyles.regularTextStyle,
                  ),
                ),
                getVerticalSpace(height: .2.h),
                customTextFormField(
                    maxLine: 4, isPrefix: false, title: "Type here..."),
                getVerticalSpace(height: 6.h),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: customElevatedButton(
                      title: 'Send',
                      width: mediaQuerySize.width,
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
