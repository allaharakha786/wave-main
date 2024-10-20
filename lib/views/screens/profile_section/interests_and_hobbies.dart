import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/controllers/utils/snackbar.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/profile_section/prepare_conversation.dart';

import '../../../model/user/user.dart';

class InterestsAndHobbies extends StatefulWidget {
  final String language;
  final int level;
  final String reason;

  const InterestsAndHobbies({super.key, required this.language, required this.level, required this.reason});

  @override
  State<InterestsAndHobbies> createState() => _InterestsAndHobbiesState();
}

class _InterestsAndHobbiesState extends State<InterestsAndHobbies> {
  final TextEditingController interestController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  final RxString _selectGender = "Male".obs;
  final RxString status = "Married".obs;
  final RxList<String> genders = ['Male', 'Female', 'Other'].obs;
  final RxList<String> maritalStatus = [
    'Married',
    'Single',
    'Divorced',
    'Widowed',
    'Separated',
    'Engaged',
    'Not Specified',
  ].obs;

  // Validation function
  bool validateFields() {
    if (interestController.text.isEmpty) {
      showErrorSnackbar('Interest cannot be empty');
      return false;
    }
    if (occupationController.text.isEmpty) {
      showErrorSnackbar('Occupation cannot be empty');
      return false;
    }
    if (countryController.text.isEmpty) {
      showErrorSnackbar('Country cannot be empty');
      return false;
    }
    if (ageController.text.isEmpty || int.tryParse(ageController.text) == null) {
      showErrorSnackbar('Age must be a valid number');
      return false;
    }
    if (heightController.text.isEmpty || double.tryParse(heightController.text) == null) {
      showErrorSnackbar('Height must be a valid number');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              getVerticalSpace(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h),
                child: Row(
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
                    getHorizentalSpace(width: 2.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Interests & Hobbies", style: AppTextStyles.onBoardingTextStyle),
                        Text("You can choose multiple options you are\ninterested in.", style: AppTextStyles.regularTextStyle),
                      ],
                    ),
                  ],
                ),
              ),
              getVerticalSpace(height: 2.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.3.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter Interest", style: AppTextStyles.regularTextStyle),
                      getVerticalSpace(height: .8.h),
                      customTextField(controller: interestController, title: "Interests", horizentalPadding: 2.h),
                      getVerticalSpace(height: 2.h),
                      Text("Your Occupation", style: AppTextStyles.regularTextStyle),
                      getVerticalSpace(height: .8.h),
                      customTextField(controller: occupationController, title: "UI/UX Designer", horizentalPadding: 2.h),
                      getVerticalSpace(height: 2.h),
                      Text("Your Country", style: AppTextStyles.regularTextStyle),
                      getVerticalSpace(height: .8.h),
                      customTextField(controller: countryController, title: "Ireland", horizentalPadding: 2.h),
                      getVerticalSpace(height: 2.h),
                      Text("Age", style: AppTextStyles.regularTextStyle),
                      getVerticalSpace(height: .8.h),
                      customTextField(controller: ageController, keyBoardType: TextInputType.number, title: "Age", horizentalPadding: 2.h),
                      getVerticalSpace(height: 2.h),
                      Text("Height", style: AppTextStyles.regularTextStyle),
                      getVerticalSpace(height: .8.h),
                      customTextField(controller: heightController, keyBoardType: TextInputType.number, title: "57", horizentalPadding: 2.h),
                      getVerticalSpace(height: 2.h),
                      Text("Gender", style: AppTextStyles.regularTextStyle),
                      getVerticalSpace(height: .8.h),
                      Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.2.h, vertical: 0.h),
                          decoration: BoxDecoration(
                            color: AppColors.textFieldBackgroundColor,
                            borderRadius: BorderRadius.circular(3.h),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(3.h),
                              value: _selectGender.value,
                              items: genders.map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender, style: AppTextStyles.regularTextStyle),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                _selectGender.value = newValue!;
                              },
                              icon: SizedBox(height: 2.h, width: 2.h, child: SvgPicture.asset("assets/svgs/downarrow.svg")),
                              isExpanded: true,
                            ),
                          ),
                        ),
                      ),
                      getVerticalSpace(height: 2.h),
                      Text("Relationship Status", style: AppTextStyles.regularTextStyle),
                      getVerticalSpace(height: .8.h),
                      Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.2.h, vertical: 0.h),
                          decoration: BoxDecoration(
                            color: AppColors.textFieldBackgroundColor,
                            borderRadius: BorderRadius.circular(3.h),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(3.h),
                              value: status.value,
                              items: maritalStatus.map((String statuss) {
                                return DropdownMenuItem<String>(
                                  value: statuss,
                                  child: Text(statuss, style: AppTextStyles.regularTextStyle),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                status.value = newValue!;
                              },
                              icon: SizedBox(height: 2.h, width: 2.h, child: SvgPicture.asset("assets/svgs/downarrow.svg")),
                              isExpanded: true,
                            ),
                          ),
                        ),
                      ),
                      getVerticalSpace(height: 3.h)
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.6.h),
                child: Row(
                  children: [
                    Expanded(
                      child: customElevatedButton(
                        height: 5.h,
                        onTap: () {
                          if (validateFields()) {
                            UserMetadata userMetadata = UserMetadata(
                              language: widget.language,
                              level: widget.level,
                              reason: widget.reason,
                              interest: interestController.text,
                              occupation: occupationController.text,
                              country: countryController.text,
                              age: int.parse(ageController.text),
                              height: double.parse(heightController.text),
                              gender: _selectGender.value,
                              relationshipStatus: status.value,
                            );

                            // Convert UserMetadata to Map and print it
                            Map<String, dynamic> userMap = userMetadata.toMap();
                            print("User Data Map: $userMap");

                            Get.to(() => PrePareConversation(
                              userMetadata: userMetadata,
                            ));
                          }
                        },
                        title: "Continue",
                      ),
                    ),
                  ],
                ),
              ),
              getVerticalSpace(height: 2.h)
            ],
          ),
        ),
      ),
    );
  }
}
