import 'package:editor/widgets/secondrow/controller/pdfcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';


class PdfView extends StatelessWidget {
  final PdfController pdfController = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (pdfController.isVisible.value) {
        return PDFView(
          filePath: pdfController.pdfUrl.value,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: true,
          pageSnap: true,
          defaultPage: 0,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation: false,
        );
      } else {
        return SizedBox.shrink();  // Empty widget when not visible
      }
    });
  }
}
