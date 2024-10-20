import 'package:get/get.dart';

class RangeController extends GetxController {
  var currentDistance = 0.0.obs;

  void updateDistance(double distance) {
    currentDistance.value = distance;
  }
}