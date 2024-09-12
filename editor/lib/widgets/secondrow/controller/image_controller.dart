import 'dart:async';

import 'package:get/get.dart';

class ImageController extends GetxController {
  var imageUrl = ''.obs;
  var isVisible = false.obs;
  var duration = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    // Initial duration is set to 3 seconds
    duration.value = Duration(seconds: 3);
  }

  void showImage(String url) {
    imageUrl.value = url;
    isVisible.value = true;

    // Hide image after the set duration
    Future.delayed(duration.value, () {
      isVisible.value = false;
    });
  }
}
