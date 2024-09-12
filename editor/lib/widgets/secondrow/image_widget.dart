import 'package:editor/widgets/secondrow/controller/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ImageView extends StatelessWidget {
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (imageController.isVisible.value) {
        return Center(
          child: Image.network(imageController.imageUrl.value),
        );
      } else {
        return SizedBox.shrink();  // Empty widget when not visible
      }
    });
  }
}
