import 'dart:async';

import 'package:get/get.dart';

class PdfController extends GetxController {
  var pdfUrl = ''.obs;
  var isVisible = false.obs;
  var duration = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    // Initial duration is set to 3 seconds
    duration.value = Duration(seconds: 3);
  }

  void showPdf(String url) {
    pdfUrl.value = url;
    isVisible.value = true;

    // Hide PDF after the set duration
    Future.delayed(duration.value, () {
      isVisible.value = false;
    });
  }
}
