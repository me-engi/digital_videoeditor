import 'package:editor/widgets/secondrow/controller/audiovideocontroller.dart';

import 'package:editor/widgets/secondrow/secondparteditor/getrepo_hive.dart';

Future<void> stretchVideoInController(String videoKey, Duration newDuration) async {
  try {
    // Retrieve video file from Hive
    final videoFile = await getVideoFileFromHive(videoKey);

    // Initialize MediaController with the path to the video
    final mediaController = MediaController(videoFile.path);

    // Define the output path for the stretched video
    final outputVideoPath = videoFile.path.replaceAll('.mp4', '_stretched.mp4');

    // Call the stretchVideo method
    await mediaController.stretchVideo(videoFile.path, outputVideoPath, newDuration);

    print("Video stretched successfully. Output saved at: $outputVideoPath");
  } catch (e) {
    print("Error stretching video: $e");
  }
}
