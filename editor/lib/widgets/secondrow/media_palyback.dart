import 'package:editor/widgets/secondrow/controller/audiovideocontroller.dart';
import 'package:editor/widgets/secondrow/controller/videobutton_controller.dart';
import 'package:flutter/material.dart';
// Import the MediaControls widget
import 'package:get/get.dart';

class MediaPlaybackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the AudioVideoController with a placeholder URL or leave empty if not required.
    final MediaController mediaController = Get.put(MediaController(""));

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Media Playback'),
      // ),
      body: Column(
        children: [
          // Container to display media (optional, depends on your media type and controller)
          Expanded(
            child: Obx(() {
              return mediaController.isPlaying.value
                  ? Center(child: Text('Media is playing...')) // Replace with actual media display
                  : Center(child: Text('No media playing'));
            }),
          ),
          // Media controls at the bottom
          MediaControls(),
        ],
      ),
    );
  }
}
