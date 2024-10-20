import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class PickerController extends GetxController {
  //Date picker
  DateTime currentDate = DateTime.now();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<String> formatedDate = '2024-5-07'.obs;
  RxBool generateUrlLoading = false.obs;

  Future<void> pickedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, firstDate: DateTime(1990), lastDate: currentDate);
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      formatedDate.value = DateFormat("yyyy-MM-dd").format(selectedDate.value);
    }
  }

  Future<String> generateNetworkUrl(File imageFile) async {
    // Get the file name
    generateUrlLoading.value = true;
    String fileName = basename(imageFile.path);

    // Create a reference to Firebase Storage
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName'); // Optional: put the image in 'uploads' folder

    // Upload the file
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

    // Wait for the upload to complete
    TaskSnapshot taskSnapshot = await uploadTask;

    // Get the download URL
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    generateUrlLoading.value = false;
    return downloadURL; // This is the URL you will store in Firestore
  }

  Future<DateTime?> selectDate(BuildContext context, DateTime initialDate) async {
    return await showDatePicker(context: context, initialDate: initialDate, firstDate: DateTime(1990), lastDate: DateTime(DateTime.now().year, DateTime.now().month + 6, DateTime.now().day));
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    return await showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  //picked Time
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  Rx<String> formatedTime = '12:30'.obs;

  Future<void> pickedTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    // If a time is picked, update selectedTime and formattedTime
    if (pickedTime != null) {
      selectedTime.value = pickedTime;
      formatedTime.value = pickedTime.format(context);
    }
  }

  //picked Image From Gallery
  final ImagePicker picker = ImagePicker();
  Rx<XFile?> pickedImage = Rx<XFile?>(null);

  Future<File?> pickImage() async {
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      pickedImage.value = selectedImage;
      return File(pickedImage.value!.path);
    }
    return null;
  }

  Future<File?> pickImageWithFile(Rx<File?> file) async {
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      file.value = File(selectedImage.path);
      return file.value;
    }
    return null;
  }

  Future<File?> pickImageOrVideo() async {
    final XFile? selectedImage = await picker.pickMedia();
    if (selectedImage != null) {
      pickedImage.value = selectedImage;
      return File(pickedImage.value!.path);
    }
    return null;
  }
}
