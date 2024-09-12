import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'audiovideocontroller.dart'; // Adjust import according to your project structure

class MediaControls extends StatelessWidget {
  final MediaController mediaController = Get.put(MediaController("")); // Initialize with a placeholder URL

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Video Preview Placeholder
        Container(
          width: double.infinity,
          height: 200, // Adjust height as needed
          color: Colors.black,
          child: Center(
            child: Text(
              'Video Preview',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 20),
        // Progress Slider
        Slider(
          value: mediaController.position.value.inMilliseconds.toDouble(),
          min: 0.0,
          max: mediaController.duration.value.inMilliseconds.toDouble(),
          onChanged: (value) {
            mediaController.seekTo(value.toInt());
          },
        ),
        // Progress and Duration Text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(mediaController.position.value),
              style: TextStyle(color: Colors.white),
            ),
            Text(
              _formatDuration(mediaController.duration.value),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 20),
        // Control Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/backward.svg'),
              iconSize: 30,
              onPressed: mediaController.backward,
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/tensec.svg'),
              iconSize: 30,
              onPressed: () {
                // Implement tenSec if required
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/minus.svg'),
              iconSize: 30,
              onPressed: () {
                // Implement decrement if required
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/play.svg'),
              iconSize: 30,
              onPressed: () => _showPlayDialog(context),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/pause.svg'),
              iconSize: 30,
              onPressed: mediaController.pause,
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/plus.svg'),
              iconSize: 30,
              onPressed: () {
                // Implement increment if required
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/forward.svg'),
              iconSize: 30,
              onPressed: mediaController.forward,
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/repeat.svg'),
              iconSize: 30,
              onPressed: mediaController.repeat,
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/volume.svg'),
              iconSize: 30,
              onPressed: () {
                mediaController.adjustVolume(0.5); // Adjust volume
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        // Additional Buttons Below Progress Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/replay.svg'),
              iconSize: 30,
              onPressed: () {
                // Implement replay functionality
                mediaController.seekTo(0); // Restart video
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/mute.svg'),
              iconSize: 30,
              onPressed: () {
                mediaController.adjustVolume(0.0); // Mute audio
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/videocontroller/fullscreen.svg'),
              iconSize: 30,
              onPressed: () {
                // Implement fullscreen functionality
              },
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showPlayDialog(BuildContext context) {
    final TextEditingController urlController = TextEditingController();
    final Box videoBox = Hive.box('videos'); // Assuming you have a Hive box named 'videos'

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Play Media"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Input field for URL
              TextField(
                controller: urlController,
                decoration: InputDecoration(hintText: "Enter the media URL"),
              ),
              SizedBox(height: 10),
              // Dropdown for selecting local video
              DropdownButton<String>(
                hint: Text("Select local video"),
                onChanged: (String? selectedVideo) {
                  if (selectedVideo != null) {
                    mediaController.play(selectedVideo); // Play the selected video
                    Get.back(); // Close the dialog
                  }
                },
                items: videoBox.keys.map<DropdownMenuItem<String>>((key) {
                  return DropdownMenuItem<String>(
                    value: videoBox.get(key),
                    child: Text(videoBox.get(key).toString()),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (urlController.text.isNotEmpty) {
                  mediaController.play(urlController.text); // Play from URL
                }
                Get.back(); // Close the dialog
              },
              child: Text("Play from URL"),
            ),
          ],
        );
      },
    );
  }
}
