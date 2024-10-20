import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wave/controllers/getx_controllers/user_controller.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/two_option_model_bottom_sheet.dart';
import 'package:wave/views/custom_widgets/custom_list_tile.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/auth_section/sign_in_screen.dart';
import 'package:wave/views/screens/profile_section/change_password.dart';
import 'package:wave/views/screens/profile_section/edit_profile.dart';
import 'package:wave/views/screens/profile_section/other_settings.dart';
import 'package:wave/views/screens/profile_section/select_your_language.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RxBool likedSwited = false.obs;

  RxBool chatSwitched = false.obs;

  RxBool commentSwitched = false.obs;

  RxBool isExpanded = false.obs;

  late UserController userController;

  @override
  void initState() {
    userController = Get.put(UserController());
    callMethods();
    super.initState();
  }

  callMethods() async {
    await userController.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Obx(() {
      DateTime dateTime = DateTime.parse(userController.userData.value?.createdAt! ?? "2024-10-17T17:27:12.843066");

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Profile'),
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  children: [
                    userController.profileLoading.value
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                  width: mediaQuerySize.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.transparent, width: 0),
                                      boxShadow: const [
                                        BoxShadow(color: Colors.black12, spreadRadius: 2, blurStyle: BlurStyle.outer, blurRadius: 5),
                                      ],
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                    child: Row(
                                      children: [
                                        Image.asset('assets/pngs/Profile_icon.png'),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              RichText(text: TextSpan(children: <TextSpan>[TextSpan(text: 'rakha', style: const TextStyle(color: Colors.black)), TextSpan(text: ' 23', style: const TextStyle(color: Colors.black54))])),
                                              const Text('joined May 12th 2020'),
                                              Text('Pakistan'),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                                width: mediaQuerySize.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.transparent, width: 0),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black12, spreadRadius: 2, blurStyle: BlurStyle.outer, blurRadius: 5),
                                    ],
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  child: Row(
                                    children: [
                                      userController.userData.value!.profileImage.isEmpty
                                          ? Image.asset('assets/pngs/Profile_icon.png')
                                          : Container(
                                              decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(userController.userData.value!.profileImage))),
                                              height: mediaQuerySize.width * 0.15,
                                              width: mediaQuerySize.width * 0.2,
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: <TextSpan>[
                                              TextSpan(text: '${userController.userData.value?.name} ', style: const TextStyle(color: Colors.black)),
                                              TextSpan(text: userController.userData.value?.userMetadata?.age.toString(), style: const TextStyle(color: Colors.black54))
                                            ])),
                                            Text('joined ${DateFormat('MMMM d, y').format(dateTime)}'),
                                            Text(userController.userData.value?.userMetadata?.country ?? ''),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                    SizedBox(
                      height: mediaQuerySize.height * 0.03,
                    ),
                    CustomListTile(
                        onTap: () {
                          Get.to(() => EditProfileScreen());
                        },
                        leadingIcon: 'assets/svgs/edit_profie_icon.svg',
                        title: 'Edit Profile',
                        subtitle: 'Update'),
                    SizedBox(
                      height: mediaQuerySize.height * 0.03,
                    ),
                    CustomListTile(
                        onTap: () {
                          Get.to(() => ChangePasswordScreen());
                        },
                        leadingIcon: 'assets/svgs/key_icon.svg',
                        title: 'Change Password',
                        subtitle: 'Manage password settings'),
                    SizedBox(
                      height: mediaQuerySize.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: mediaQuerySize.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.transparent, width: 0),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, spreadRadius: 2, blurStyle: BlurStyle.outer, blurRadius: 5),
                            ],
                            color: Colors.white),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                isExpanded.value = !isExpanded.value;
                              },
                              leading: SvgPicture.asset('assets/svgs/notification_icon.svg'),
                              title: const Text('Notification'),
                              subtitle: const Text('Manage notification settings'),
                              trailing: SvgPicture.asset(!isExpanded.value ? 'assets/svgs/arrow_down.svg' : 'assets/svgs/arrow_up.svg'),
                            ),
                            isExpanded.value
                                ? Padding(
                                    padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.08, vertical: 6),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text('Like'),
                                            const Spacer(),
                                            Switch(
                                              value: likedSwited.value,
                                              onChanged: (value) {
                                                likedSwited.value = !likedSwited.value;
                                              },
                                              activeTrackColor: Colors.blueAccent,
                                              activeColor: Colors.white,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 0.1,
                                        ),
                                        Row(
                                          children: [
                                            const Text('Chat'),
                                            const Spacer(),
                                            Switch(
                                              value: chatSwitched.value,
                                              onChanged: (value) {
                                                chatSwitched.value = !chatSwitched.value;
                                              },
                                              activeTrackColor: Colors.blueAccent,
                                              activeColor: Colors.white,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 0.1,
                                        ),
                                        Row(
                                          children: [
                                            const Text('Comments'),
                                            const Spacer(),
                                            Switch(
                                              value: commentSwitched.value,
                                              onChanged: (value) {
                                                commentSwitched.value = !commentSwitched.value;
                                              },
                                              activeTrackColor: Colors.blueAccent,
                                              activeColor: Colors.white,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 0.1,
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuerySize.height * 0.03,
                    ),
                    CustomListTile(
                        onTap: () {
                          Get.to(() => SelectYourLanguage(
                                screenName: 'change',
                              ));
                        },
                        leadingIcon: 'assets/svgs/language_icon.svg',
                        title: 'Language',
                        subtitle: 'English'),
                    SizedBox(
                      height: mediaQuerySize.height * 0.03,
                    ),
                    CustomListTile(
                        onTap: () {
                          Get.to(() => const OtherSettingScreen());
                        },
                        leadingIcon: 'assets/svgs/other_icon.svg',
                        title: 'Other',
                        subtitle: 'Privacy Policy, Terms & Conditions'),
                    SizedBox(
                      height: mediaQuerySize.height * 0.03,
                    ),
                    CustomListTile(
                        onTap: () {
                          showCommonModalBottomSheet(
                            context: context,
                            iconPath: 'assets/pngs/delete_icon.png',
                            title: 'Are you sure?',
                            description: "Hide your account if you want to take a break, If you delete your account, all likes, matches, and chats will be gone forever.",
                            button1Text: "Never mind",
                            button2Text: "Delete Account",
                            button1Callback: () {
                              Get.back();
                            },
                            button2Callback: () {
                              FirebaseAuth.instance.currentUser?.delete();
                              Get.offAll(() => const SignInScreen());
                            },
                          );
                        },
                        leadingIcon: 'assets/svgs/delete_icon.svg',
                        title: 'Delete Account',
                        subtitle: 'Delete account permanently'),
                    SizedBox(
                      height: mediaQuerySize.height * 0.03,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: customElevatedButton(
                        onTap: () {
                          showCommonModalBottomSheet(
                            context: context,
                            iconPath: "assets/pngs/logout_icon.png",
                            title: "Logout",
                            description: "Are you sure to logout?",
                            button1Text: "No",
                            button2Text: "Yes",
                            loading: userController.loading.value,
                            button1Callback: () {
                              Get.back();
                            },
                            button2Callback: () {
                              userController.logout();
                            },
                          );
                        },
                        title: 'Logout',
                        width: mediaQuerySize.width,
                        bgColor: Colors.red,
                        borderColor: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: mediaQuerySize.height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
