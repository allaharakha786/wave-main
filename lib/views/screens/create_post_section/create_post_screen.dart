import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import '../../../controllers/getx_controllers/post_controller.dart';
import '../../../controllers/getx_controllers/picker_controller.dart';
import '../../../controllers/utils/snackbar.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final PickerController pickerController = Get.put(PickerController());
  final PostController postController = Get.put(PostController());
  final TextEditingController thoughtsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  RxList<String> tagsList = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerticalSpace(height: 5.h),
            Padding(
              padding: EdgeInsets.only(left: 2.4.h, right: 2.4.h, top: 2.4.h),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!postController.isLoading.value)
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: AppTextStyles.boldTextStyle.copyWith(fontSize: 16.px, color: AppColors.redColor),
                        ),
                      ),
                    Text(
                      "Moments",
                      style: AppTextStyles.boldTextStyle.copyWith(fontSize: 16.px),
                    ),
                    postController.isLoading.value
                        ? Text(
                            "Posting...",
                            style: AppTextStyles.boldTextStyle.copyWith(fontSize: 16.px, color: AppColors.primaryColor),
                          ) // Show loading indicator if loading
                        : GestureDetector(
                            onTap: () async {
                              await validateAndPost().then(
                                (value) {
                                  if(value)
                                    {
                                      Navigator.pop(context);
                                    }
                                },
                              );
                            },
                            child: Text(
                              "Post",
                              style: AppTextStyles.boldTextStyle.copyWith(fontSize: 16.px, color: AppColors.primaryColor),
                            ),
                          )
                  ],
                );
              }),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getVerticalSpace(height: 3.h),
                      Text(
                        "Share your thoughts...",
                        style: AppTextStyles.regularTextStyle,
                      ),
                      getVerticalSpace(height: .8.h),
                      customTextField(
                        controller: thoughtsController,
                        horizentalPadding: 2.h,
                        title: "UI/UX Designer",
                      ),
                      getVerticalSpace(height: 2.4.h),
                      Text(
                        "Upload Image",
                        style: AppTextStyles.regularTextStyle,
                      ),
                      getVerticalSpace(height: .8.h),
                      Container(
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColors.textFieldBackgroundColor,
                          borderRadius: BorderRadius.circular(20.px),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            pickerController.pickImage();
                          },
                          child: Obx(
                            () => pickerController.pickedImage.value == null
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.camera_alt,
                                          color: AppColors.lightGreyColor,
                                        ),
                                        Text(
                                          "Click to Upload",
                                          style: AppTextStyles.regularTextStyle,
                                        )
                                      ],
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20.px),
                                    child: Image.file(
                                      File(pickerController.pickedImage.value!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      getVerticalSpace(height: 2.4.h),
                      Text(
                        "Add Tags (Optional)",
                        style: AppTextStyles.regularTextStyle,
                      ),
                      getVerticalSpace(height: .8.h),
                      customTextField(
                        controller: tagsController,
                        horizentalPadding: 2.h,
                        title: "Enter tags separated by commas",
                        onChanged: (value) {
                          if (value.endsWith(',')) {
                            addTag(value);
                          }
                        },
                      ),
                      getVerticalSpace(height: 2.h),
                      Obx(() => Wrap(
                            spacing: 4.0,
                            children: tagsList.map((tag) {
                              return Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.px), // Adjust the radius as needed
                                ),
                                backgroundColor: AppColors.textFieldBackgroundColor,
                                label: Text(tag),
                                // Add a delete icon to each chip
                                deleteIcon: const Icon(Icons.close),
                                onDeleted: () {
                                  tagsList.remove(tag);
                                },
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to validate and post
  Future<bool> validateAndPost() async {
    bool isValue = false;
    if (thoughtsController.text.isEmpty && pickerController.pickedImage.value == null) {
      showErrorSnackbar("Please add a thought or an image before posting.");
    } else {
      await postController.createPost(thoughtsController.text, pickerController.pickedImage.value, tagsList).then(
        (value) {
          isValue = value;
        },
      );
    }
    return isValue;
  }

  // Function to add tags
  void addTag(String value) {
    String trimmedTag = value.replaceAll(',', '').trim();
    if (trimmedTag.isNotEmpty) {
      tagsList.add(trimmedTag);
      tagsController.clear();
    }
  }
}
