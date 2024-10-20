import 'package:firebase_auth/firebase_auth.dart' hide UserMetadata;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/getx_controllers/user_controller.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/controllers/utils/firestore_utils.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/bottom_nav_bar.dart';
import '../../../model/user/user.dart';

class PrePareConversation extends StatefulWidget {
  final UserMetadata userMetadata;

  const PrePareConversation({
    super.key,
    required this.userMetadata,
  });

  @override
  State<PrePareConversation> createState() => _PrePareConversationState();
}

class _PrePareConversationState extends State<PrePareConversation> {
  late UserController userController;

  @override
  void initState() {
    userController = Get.put(UserController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getVerticalSpace(height: 5.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SizedBox(
                      height: 4.h,
                      width: 4.h,
                      child: SvgPicture.asset(
                        "assets/svgs/arrow_back.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              getVerticalSpace(height: 18.h),
              const Image(
                image: AssetImage("assets/pngs/conversation.png"),
                fit: BoxFit.cover,
              ),
              getVerticalSpace(height: 3.h),
              Text(
                "Let’s prepare you for conversation",
                style: AppTextStyles.regularLargeTextStyle,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                          height: 5.h,
                          loading: userController.loading.value,
                          onTap: () async {
                            await userController.addUserMetadata(FirestoreUtils().getUid(), widget.userMetadata.toMap()).then(
                              (value) {
                                if (value) {
                                  Get.offAll(() => CustomBottomNavigationBar());
                                }
                              },
                            );
                          },
                          title: "Continue",
                        ),
                      ),
                    ],
                  ),
                );
              }),
              getVerticalSpace(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
