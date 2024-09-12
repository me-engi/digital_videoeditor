// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:js/js.dart';

// class VideoEditorController extends GetxController {
//   // Function to crop a video using the JS interop function
//   Future<void> cropVideo(String inputFile, String outputFile, int width, int height, int x, int y) async {
//     try {
//       String result = await cropVideo(inputFile, outputFile, width, height, x, y);
//       print("Video cropped: $result");
//     } catch (e) {
//       print("Error cropping video: $e");
//     }
//   }

//   // Function to add text to a video using the JS interop function
//   Future<void> addTextToVideo(String inputFile, String outputFile, String text, int x, int y) async {
//     try {
//       String result = await addTextToVideo(inputFile, outputFile, text, x, y);
//       print("Text added to video: $result");
//     } catch (e) {
//       print("Error adding text to video: $e");
//     }
//   }

//   // Function to overlay an image on a video using the JS interop function
//   Future<void> overlayImageOnVideo(String inputFile, String outputFile, String imageFile, int x, int y) async {
//     try {
//       String result = await overlayImageOnVideo(inputFile, outputFile, imageFile, x, y);
//       print("Image overlayed on video: $result");
//     } catch (e) {
//       print("Error overlaying image on video: $e");
//     }
//   }

//   // Function to adjust audio volume of a video using the JS interop function
//   Future<void> adjustAudioVolume(String inputFile, String outputFile, double volume) async {
//     try {
//       String result = await adjustAudioVolume(inputFile, outputFile, volume);
//       print("Audio volume adjusted: $result");
//     } catch (e) {
//       print("Error adjusting audio volume: $e");
//     }
//   }
// }
