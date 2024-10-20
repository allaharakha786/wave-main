import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Common constants for the snackbar
const String successTitle = "Success";
const Color successBackgroundColor = Colors.green;
const Color errorBackgroundColor = Colors.red;
const Duration animationDuration = Duration(milliseconds: 200);
const Duration duration = Duration(milliseconds: 1500);

// Show Success Snackbar (Global function)
void showSuccessSnackbar(String message) {
  Get.snackbar(
    successTitle,       // Common title for success
    message,
    backgroundColor: successBackgroundColor,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    animationDuration: animationDuration,
    duration: duration,
    margin: const EdgeInsets.all(8.0),
  );
}

// Show Error Snackbar (Global function)
void showErrorSnackbar(String message) {
  Get.snackbar(
    'Error',           // Title for error
    message,
    backgroundColor: errorBackgroundColor,
    colorText: Colors.white,
    duration: duration,
    snackPosition: SnackPosition.TOP,
    animationDuration: animationDuration,
    margin: const EdgeInsets.all(8.0),
  );
}
