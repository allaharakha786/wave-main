import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/views/screens/bottom_nav_bar.dart';
import 'package:wave/views/screens/profile_section/ready_for_questions.dart';
import '../../controllers/utils/firestore_utils.dart';
import 'home_section/home_screen.dart';
import 'on_boarding_section/onboarding_tabs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirestoreUtils firestoreUtils = FirestoreUtils();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Use post-frame callback for navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
  }

  // Check if user is logged in and metadata status
  Future<void> _checkLoginStatus() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // User is logged in, check if metadata is added
      final String uid = user.uid;
      try {
        final userDoc = await firestoreUtils.getDocument(
          collectionName: 'users',
          docId: uid,
        );

        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>?;

          final bool metaDataAdded = userData?['metaDataAdded'] ?? false;

          if (metaDataAdded) {
            Get.off(() => CustomBottomNavigationBar());
          } else {
            Get.off(() => const ReadyForQuestions());
          }
        } else {
          Get.off(() => const OnboardingTabs());
        }
      } catch (e) {
        // Handle error, log or show message to user
        debugPrint("Error fetching user document: $e");
        // You might want to navigate to OnboardingTabs or show an error message
        Get.off(() => const OnboardingTabs());
      }
    } else {
      Get.off(() => const OnboardingTabs());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Wave",
          style: AppTextStyles.boldTextStyleSplash,
        ),
      ),
    );
  }
}
