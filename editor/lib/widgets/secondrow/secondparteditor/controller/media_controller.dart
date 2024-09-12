// // The library directive should be the first thing in the file
// library ffmpeg_js;

// import 'dart:js_interop'; // Import JS interop for Dart-JS interaction
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';

// // Define external JS functions from ffmpeg.wasm
// @JS('createFFmpeg')
// external dynamic createFFmpeg(Map<String, dynamic> config); // Create FFmpeg instance

// @JS()
// external Future<void> load(); // Load FFmpeg

// @JS()
// external Future<void> run(List<String> command); // Run FFmpeg command

// class MediaController extends GetxController {
//   VideoPlayerController? _videoPlayerController;
//   var isPlaying = false.obs;
//   var isPaused = false.obs;
//   var duration = Duration.zero.obs;
//   var position = Duration.zero.obs;
//   var progress = 0.0.obs;

//   // Initialize the video controller with the given video URL
//   MediaController(String videoUrl) {
//     _videoPlayerController = VideoPlayerController.network(videoUrl)
//       ..addListener(() {
//         isPlaying.value = _videoPlayerController!.value.isPlaying;
//         isPaused.value = !_videoPlayerController!.value.isPlaying;
//         position.value = _videoPlayerController!.value.position;
//         duration.value = _videoPlayerController!.value.duration ?? Duration.zero;
//         progress.value = getProgressPercentage();
//       });
//     _videoPlayerController!.initialize().then((_) => update());
//   }

//   // Function to load ffmpeg.wasm
//   Future<void> loadFFmpeg() async {
//     final ffmpeg = createFFmpeg({"log": true});
//     await load(); // Load the ffmpeg.wasm core
//     print("FFmpeg loaded");
//   }

//   // Function to add a text overlay to a video using ffmpeg.wasm
//   Future<void> addTextOverlay(String text, String inputVideoPath, String outputVideoPath) async {
//     final command = ['-i', inputVideoPath, '-vf', 'drawtext=text=\'$text\':fontcolor=white:fontsize=24', outputVideoPath];
//     await run(command); // Use ffmpeg.wasm to run the command
//     print("Text overlay added");
//   }

//   // Function to add an image overlay to a video
//   Future<void> addImageOverlay(String imagePath, String inputVideoPath, String outputVideoPath, int x, int y) async {
//     final command = ['-i', inputVideoPath, '-i', imagePath, '-filter_complex', 'overlay=$x:$y', outputVideoPath];
//     await run(command); // Add the image as an overlay to the video
//     print("Image overlay added");
//   }

//   // Function to add a PDF layer to a video (by converting each page of the PDF to an image first)
//   Future<void> addPdfOverlay(String pdfPath, String inputVideoPath, String outputVideoPath, int x, int y) async {
//     // Convert PDF to images first (this can be handled in another function), and then overlay those images
//     // Assuming the conversion logic is handled separately and we have imagePath from the PDF
//     final imagePath = 'converted_image.png'; // Placeholder for the converted PDF page image
//     await addImageOverlay(imagePath, inputVideoPath, outputVideoPath, x, y);
//   }

//   // Function to trim a video
//   Future<void> trimVideo(String inputVideoPath, String outputVideoPath, Duration startTime, Duration endTime) async {
//     final start = startTime.inSeconds.toString();
//     final duration = (endTime - startTime).inSeconds.toString();
//     final command = ['-i', inputVideoPath, '-ss', start, '-t', duration, '-c', 'copy', outputVideoPath];
//     await run(command); // Trim the video using ffmpeg.wasm
//     print("Video trimmed from $startTime to $endTime");
//   }

//   // Function to add audio to video using ffmpeg.wasm
//   Future<void> addAudioToVideo(String audioPath, String inputVideoPath, String outputVideoPath) async {
//     final command = ['-i', inputVideoPath, '-i', audioPath, '-c:v', 'copy', '-c:a', 'aac', '-strict', 'experimental', outputVideoPath];
//     await run(command); // Run the FFmpeg command to add audio to the video
//     print("Audio added to video");
//   }

//   // Calculate the progress percentage for video playback
//   double getProgressPercentage() {
//     if (duration.value.inMilliseconds == 0) return 0.0;
//     return position.value.inMilliseconds / duration.value.inMilliseconds;
//   }

//   // Clean up resources when the controller is closed
//   @override
//   void onClose() {
//     _videoPlayerController?.dispose();
//     super.onClose();
//   }
// }
