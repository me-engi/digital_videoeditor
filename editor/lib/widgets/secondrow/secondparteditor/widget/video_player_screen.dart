// import 'package:editor/widgets/secondrow/controller/audiovideocontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// // Assuming your MediaController is in this file

// class VideoPreview extends StatefulWidget {
//   final String videoUrl;

//   VideoPreview({required this.videoUrl});

//   @override
//   _VideoPreviewState createState() => _VideoPreviewState();
// }

// class _VideoPreviewState extends State<VideoPreview> {
//   late MediaController _mediaController;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the MediaController with the provided video URL
//     _mediaController = MediaController(widget.videoUrl);
//     // Load ffmpeg wasm on initialization
//     _mediaController.loadFFmpeg();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Preview'),
//       ),
//       body: Column(
//         children: [
//           // Video Player section
//           Obx(() {
//             if (_mediaController._videoPlayerController != null &&
//                 _mediaController._videoPlayerController!.value.isInitialized) {
//               return AspectRatio(
//                 aspectRatio: _mediaController._videoPlayerController!.value.aspectRatio,
//                 child: VideoPlayer(_mediaController._videoPlayerController!),
//               );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           }),

//           // Playback and editing controls
//           SizedBox(height: 20),
//           Obx(() => _buildControlButtons()),

//           // Trimming Section
//           _buildTrimSection(),

//           // Text Overlay Section
//           _buildTextOverlaySection(),

//           // Image Overlay Section
//           _buildImageOverlaySection(),

//           // Audio Overlay Section
//           _buildAudioOverlaySection(),
//         ],
//       ),
//     );
//   }

//   // Control buttons for play, pause, forward, backward
//   Widget _buildControlButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         IconButton(
//           icon: Icon(Icons.replay_10),
//           onPressed: () => _mediaController.backward(),
//         ),
//         IconButton(
//           icon: _mediaController.isPlaying.value ? Icon(Icons.pause) : Icon(Icons.play_arrow),
//           onPressed: () {
//             if (_mediaController.isPlaying.value) {
//               _mediaController.pause();
//             } else {
//               _mediaController.play(widget.videoUrl);
//             }
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.forward_10),
//           onPressed: () => _mediaController.forward(),
//         ),
//       ],
//     );
//   }

//   // Build trim video section
//   Widget _buildTrimSection() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Trim Video:"),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   await _mediaController.trimVideo(
//                     'input.mp4', // Replace with your actual file paths
//                     'output.mp4',
//                     Duration(seconds: 10),
//                     Duration(seconds: 20),
//                   );
//                 },
//                 child: Text('Trim Video (10s - 20s)'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Build text overlay section
//   Widget _buildTextOverlaySection() {
//     final TextEditingController textController = TextEditingController();
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Text Overlay:"),
//           TextField(
//             controller: textController,
//             decoration: InputDecoration(labelText: 'Enter text'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await _mediaController.addTextOverlay(
//                 textController.text,
//                 'input.mp4', // Replace with your actual video file paths
//                 'output.mp4',
//               );
//             },
//             child: Text('Apply Text Overlay'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Build image overlay section
//   Widget _buildImageOverlaySection() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Image Overlay:"),
//           ElevatedButton(
//             onPressed: () async {
//               await _mediaController.addImageOverlay(
//                 'image.png', // Replace with actual image path
//                 'input.mp4',
//                 'output.mp4',
//                 10, // X-coordinate for overlay position
//                 10, // Y-coordinate for overlay position
//               );
//             },
//             child: Text('Apply Image Overlay'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Build audio overlay section
//   Widget _buildAudioOverlaySection() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Audio Overlay:"),
//           ElevatedButton(
//             onPressed: () async {
//               await _mediaController.addAudioToVideo(
//                 'audio.mp3', // Replace with actual audio file path
//                 'input.mp4',
//                 'output.mp4',
//               );
//             },
//             child: Text('Apply Audio Overlay'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _mediaController.onClose();
//     super.dispose();
//   }
// }
