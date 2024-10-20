import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/profile_section/about_your_language_knowledge.dart';

// Define the Language model
// ignore: camel_case_types
class selectLanguage {
  final String name;
  final String emoji;
  final String code;

  selectLanguage({required this.name, required this.emoji, this.code = ''});
}

// ignore: must_be_immutable
class SelectYourLanguage extends StatefulWidget {
  String screenName;
  SelectYourLanguage({super.key, required this.screenName});

  @override
  State<SelectYourLanguage> createState() => _SelectYourLanguageState();
}

class _SelectYourLanguageState extends State<SelectYourLanguage> {
  final TextEditingController searchController = TextEditingController();
  List<selectLanguage> _languages = [];
  List<selectLanguage> _filteredLanguages = [];
  final RxInt selectedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    _languages = getLanguageList();
    _filteredLanguages = _languages;
    searchController.addListener(_filterLanguages);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterLanguages);
    searchController.dispose();
    super.dispose();
  }

  void _filterLanguages() {
    final query = searchController.text.toLowerCase();
    setState(() {
      _filteredLanguages = _languages.where((language) {
        return language.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  List<selectLanguage> getLanguageList() {
    return [
      selectLanguage(name: 'Mandarin', emoji: '🇨🇳', code: 'zh'),
      selectLanguage(name: 'Spanish', emoji: '🇪🇸', code: 'es'),
      selectLanguage(name: 'English', emoji: '🇬🇧', code: 'en'),
      selectLanguage(name: 'Hindi', emoji: '🇮🇳', code: 'hi'),
      selectLanguage(name: 'Arabic', emoji: '🇦🇪', code: 'ar'),
      selectLanguage(name: 'Bengali', emoji: '🇧🇩', code: 'bn'),
      selectLanguage(name: 'Portuguese', emoji: '🇵🇹', code: 'pt'),
      selectLanguage(name: 'Russian', emoji: '🇷🇺', code: 'ru'),
      selectLanguage(name: 'Japanese', emoji: '🇯🇵', code: 'ja'),
      selectLanguage(name: 'German', emoji: '🇩🇪', code: 'de'),
      selectLanguage(name: 'Korean', emoji: '🇰🇷', code: 'ko'),
      selectLanguage(name: 'French', emoji: '🇫🇷', code: 'fr'),
      selectLanguage(name: 'Turkish', emoji: '🇹🇷', code: 'tr'),
      selectLanguage(name: 'Vietnamese', emoji: '🇻🇳', code: 'vi'),
      selectLanguage(name: 'Italian', emoji: '🇮🇹', code: 'it'),
      selectLanguage(name: 'Thai', emoji: '🇹🇭', code: 'th'),
      selectLanguage(name: 'Dutch', emoji: '🇳🇱', code: 'nl'),
      selectLanguage(name: 'Swedish', emoji: '🇸🇪', code: 'sv'),
      selectLanguage(name: 'Greek', emoji: '🇬🇷', code: 'el'),
      selectLanguage(name: 'Hebrew', emoji: '🇮🇱', code: 'he'),
      selectLanguage(name: 'Czech', emoji: '🇨🇿', code: 'cs'),
      selectLanguage(name: 'Polish', emoji: '🇵🇱', code: 'pl'),
      selectLanguage(name: 'Romanian', emoji: '🇷🇴', code: 'ro'),
      selectLanguage(name: 'Hungarian', emoji: '🇭🇺', code: 'hu'),
      selectLanguage(name: 'Danish', emoji: '🇩🇰', code: 'da'),
      selectLanguage(name: 'Finnish', emoji: '🇫🇮', code: 'fi'),
      selectLanguage(name: 'Norwegian', emoji: '🇳🇴', code: 'no'),
      selectLanguage(name: 'Swahili', emoji: '🇰🇪', code: 'sw'),
      selectLanguage(name: 'Malay', emoji: '🇲🇾', code: 'ms'),
      selectLanguage(name: 'Filipino', emoji: '🇵🇭', code: 'tl'),
      selectLanguage(name: 'Ukrainian', emoji: '🇺🇦', code: 'uk'),
      selectLanguage(name: 'Serbian', emoji: '🇷🇸', code: 'sr'),
      selectLanguage(name: 'Bulgarian', emoji: '🇧🇬', code: 'bg'),
      selectLanguage(name: 'Croatian', emoji: '🇭🇷', code: 'hr'),
      selectLanguage(name: 'Slovak', emoji: '🇸🇰', code: 'sk'),
      selectLanguage(name: 'Lithuanian', emoji: '🇱🇹', code: 'lt'),
      selectLanguage(name: 'Latvian', emoji: '🇱🇻', code: 'lv'),
      selectLanguage(name: 'Estonian', emoji: '🇪🇪', code: 'et'),
      selectLanguage(name: 'Icelandic', emoji: '🇮🇸', code: 'is'),
      selectLanguage(name: 'Catalan', emoji: '🇪🇸', code: 'ca'),
      selectLanguage(name: 'Basque', emoji: '🇪🇸', code: 'eu'),
      selectLanguage(name: 'Galician', emoji: '🇪🇸', code: 'gl'),
      selectLanguage(name: 'Maltese', emoji: '🇲🇹', code: 'mt'),
      selectLanguage(name: 'Urdu', emoji: '🇵🇰', code: 'ur'), // Added Urdu

      // Add more languages as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    // log("list of languages:${_languages.length}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/svgs/arrow_back.svg"),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title:
            Text("Select Language", style: AppTextStyles.onBoardingTextStyle),
        backgroundColor: AppColors.whiteColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Center(
            child: Text("Choose the language you want to learn",
                style: AppTextStyles.regularTextStyle),
          ),
          SizedBox(height: 2.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.px),
            child: customTextFormField(
              controller: searchController,
              title: "Search",
              prefix: "assets/svgs/search.svg",
              prefixSize: 0.04.h,
            ),
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: _filteredLanguages.length,
                  itemBuilder: (context, index) {
                    final language = _filteredLanguages[index];
                    return Obx(
                      () => Container(
                        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 25.px),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  const Color(0xff000000).withOpacity(0.15),
                              offset: const Offset(2, 2),
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Text(
                            language.emoji,
                            style: const TextStyle(fontSize: 30),
                          ),
                          title: Text(language.name),
                          trailing: SizedBox(
                            height: 2.3.h,
                            width: 2.4.h,
                            child: SvgPicture.asset(
                              selectedIndex.value == index
                                  ? "assets/svgs/select.svg"
                                  : "assets/svgs/unselect.svg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedIndex.value = index;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 2.h,
                  left: widget.screenName.toLowerCase().contains('change')
                      ? 0
                      : 4.h,
                  right: widget.screenName.toLowerCase().contains('change')
                      ? 0
                      : 4.h,
                  child: widget.screenName.toLowerCase().contains('change')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customElevatedButton(
                                  width: mediaQuerySize.width * 0.43,
                                  title: 'Cancel',
                                  titleColor: AppColors.primaryColor,
                                  bgColor: Colors.white,
                                  borderColor: AppColors.primaryColor),
                              customElevatedButton(
                                title: 'Change',
                                width: mediaQuerySize.width * 0.43,
                              )
                            ],
                          ),
                        )
                      : customElevatedButton(
                          height: 5.h,
                          onTap: () {
                            final selectedLanguage =
                                _filteredLanguages[selectedIndex.value];
                            Get.to(() => AboutYourLanguageKnowledge(
                                  language: selectedLanguage,
                                ));
                          },
                          title: "Continue",
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
