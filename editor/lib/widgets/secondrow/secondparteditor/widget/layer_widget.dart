import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

enum MediaType {
  video,
  audio,
  document,
  pdf,
  image,
}

class LayerData {
  String label;
  bool isLocked;
  bool isVisible;
  final MediaType mediaType;

  LayerData({
    required this.label,
    required this.isLocked,
    required this.isVisible,
    required this.mediaType,
  });
}

class MediaEditor extends StatefulWidget {
  const MediaEditor({Key? key}) : super(key: key);

  @override
  _MediaEditorState createState() => _MediaEditorState();
}

class _MediaEditorState extends State<MediaEditor> {
  late InAppWebViewController _webViewController;
  DropzoneViewController? dropzoneController;
  RxString dropzoneMessage = 'Drag media here'.obs;
  RxBool isHighlighted = false.obs;
  RxList<LayerData> layers = <LayerData>[
    LayerData(label: 'V1', isLocked: false, isVisible: true, mediaType: MediaType.video),
    LayerData(label: 'V2', isLocked: false, isVisible: true, mediaType: MediaType.video),
    LayerData(label: 'A1', isLocked: true, isVisible: false, mediaType: MediaType.audio),
    LayerData(label: 'A2', isLocked: true, isVisible: false, mediaType: MediaType.audio),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Media Editor', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.dataFromString(_ffmpegJsHtml(), mimeType: 'text/html'),
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onLoadStop: (controller, url) {
                print('WebView Loaded');
              },
            ),
          ),
          ToolBar(
            onCrop: _handleCrop,
            onAddText: _handleAddText,
            onAddImage: _handleAddImage,
            onApplyFilter: _handleApplyFilter,
          ),
          PlaybackControls(onPlay: _handlePlay),
          Expanded(
            child: Obx(() => ListView(
              children: layers.map((layer) {
                return LayerWidget(
                  layerName: layer.label,
                  mediaType: layer.mediaType,
                  isLocked: layer.isLocked,
                  isVisible: layer.isVisible,
                  onLockToggle: (mediaType) => _toggleLayerLock(layer),
                  onVisibilityToggle: (mediaType) => _toggleLayerVisibility(layer),
                  onMediaDrop: _handleMediaDrop,
                );
              }).toList(),
            )),
          ),
        ],
      ),
    );
  }

  // Layer control methods
  void _toggleLayerLock(LayerData layer) {
    layer.isLocked = !layer.isLocked;
    layers.refresh();
  }

  void _toggleLayerVisibility(LayerData layer) {
    layer.isVisible = !layer.isVisible;
    layers.refresh();
  }

  void _handleMediaDrop(MediaType mediaType, String data) {
    if (mediaType == MediaType.video) {
      print('Video dropped on ${mediaType.toString().split('.').last} layer: $data');
      extractFrameFromVideo(data, 'frame_image.png', Duration(seconds: 10));
    } else {
      print('Media dropped on ${mediaType.toString().split('.').last} layer: $data');
    }
  }

  // Toolbar actions for adding text, cropping, etc.
  void _handleCrop() {
    _webViewController.evaluateJavascript(source: "cropVideo();");
  }

  void _handleAddText() {
    _webViewController.evaluateJavascript(source: "addTextOverlay();");
  }

  void _handleAddImage() {
    _webViewController.evaluateJavascript(source: "addImageOverlay();");
  }

  void _handleApplyFilter() {
    _webViewController.evaluateJavascript(source: "applyFilter();");
  }

  void _handlePlay() {
    _webViewController.evaluateJavascript(source: "playMedia();");
  }

  Future<String?> extractFrameFromVideo(String inputVideo, String outputImage, Duration timestamp) async {
    try {
      // Ensure FFmpeg instance is loaded
      await _loadFFmpeg();

      // Get temporary directory for saving the output file
      final directory = await getTemporaryDirectory();
      final outputFilePath = '${directory.path}/$outputImage';
      
      // Define the FFmpeg command
      final command = [
        '-i', inputVideo,
        '-ss', timestamp.inSeconds.toString(),
        '-frames:v', '1',
        outputFilePath
      ];
      
      // Run the FFmpeg command
      await _runFFmpegCommand(command);

      print("Frame extracted successfully at $timestamp");
      return outputFilePath;
    } catch (e) {
      print("Error extracting frame from video: $e");
      return null;
    }
  }

  // Load the FFmpeg instance in the browser
  Future<void> _loadFFmpeg() async {
    final jsCode = '''
      if (!window.ffmpeg) {
        const { createFFmpeg } = FFmpeg;
        window.ffmpeg = createFFmpeg({ log: true });
        await window.ffmpeg.load();
      }
    ''';
    await _webViewController.evaluateJavascript(source: jsCode);
  }

  // Run FFmpeg command using the FFmpeg WASM instance
  Future<void> _runFFmpegCommand(List<String> command) async {
    final jsCode = '''
      async function runFFmpegCommand(command) {
        const ffmpeg = window.ffmpeg;
        if (!ffmpeg) {
          throw new Error("FFmpeg instance is not loaded.");
        }
        await ffmpeg.run(...command);
        const data = ffmpeg.FS('readFile', 'output.mp4');
        const blob = new Blob([data.buffer], { type: 'video/mp4' });
        const url = URL.createObjectURL(blob);
        return url;
      }
      runFFmpegCommand(${command.map((c) => '"$c"').toList()});
    ''';
    await _webViewController.evaluateJavascript(source: jsCode);
  }

  // Sample HTML + JS for ffmpeg.wasm integration
  String _ffmpegJsHtml() {
    return '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>FFmpeg WASM</title>
      <script src="https://cdn.jsdelivr.net/npm/@ffmpeg/ffmpeg@0.10.0"></script>
    </head>
    <body style="margin: 0; background-color: black;">
      <video id="videoPlayer" controls style="width: 100%; height: auto;"></video>
      <script>
        const { createFFmpeg, fetchFile } = FFmpeg;
        const ffmpeg = createFFmpeg({ log: true });

        async function loadFFmpeg() {
          await ffmpeg.load();
        }

        async function cropVideo() {
          if (!ffmpeg.isLoaded()) await loadFFmpeg();
          await ffmpeg.run('-i', 'input.mp4', '-vf', 'crop=640:360', 'output.mp4');
          const data = ffmpeg.FS('readFile', 'output.mp4');
          const video = document.getElementById('videoPlayer');
          video.src = URL.createObjectURL(new Blob([data.buffer], { type: 'video/mp4' }));
          video.play();
        }

        function addTextOverlay() {}

        function addImageOverlay() {}

        function applyFilter() {}

        function playMedia() {
          const video = document.getElementById('videoPlayer');
          video.play();
        }
      </script>
    </body>
    </html>
    ''';
  }
}

// Toolbar for crop, add text, etc.
class ToolBar extends StatelessWidget {
  final Function() onCrop;
  final Function() onAddText;
  final Function() onAddImage;
  final Function() onApplyFilter;

  const ToolBar({
    Key? key,
    required this.onCrop,
    required this.onAddText,
    required this.onAddImage,
    required this.onApplyFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.crop, color: Colors.white),
          onPressed: onCrop,
        ),
        IconButton(
          icon: const Icon(Icons.text_fields, color: Colors.white),
          onPressed: onAddText,
        ),
        IconButton(
          icon: const Icon(Icons.image, color: Colors.white),
          onPressed: onAddImage,
        ),
        IconButton(
          icon: const Icon(Icons.filter, color: Colors.white),
          onPressed: onApplyFilter,
        ),
      ],
    );
  }
}

// Playback controls
class PlaybackControls extends StatelessWidget {
  final Function() onPlay;

  const PlaybackControls({
    Key? key,
    required this.onPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.play_arrow, color: Colors.white),
          onPressed: onPlay,
        ),
      ],
    );
  }
}

// Layer widget for managing media
class LayerWidget extends StatelessWidget {
  final String layerName;
  final MediaType mediaType;
  final bool isLocked;
  final bool isVisible;
  final Function(MediaType) onLockToggle;
  final Function(MediaType) onVisibilityToggle;
  final Function(MediaType, String) onMediaDrop;

  const LayerWidget({
    Key? key,
    required this.layerName,
    required this.mediaType,
    required this.isLocked,
    required this.isVisible,
    required this.onLockToggle,
    required this.onVisibilityToggle,
    required this.onMediaDrop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListTile(
      title: Text(layerName, style: TextStyle(color: Colors.white)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(isLocked ? Icons.lock : Icons.lock_open, color: Colors.white),
            onPressed: () => onLockToggle(mediaType),
          ),
          IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white),
            onPressed: () => onVisibilityToggle(mediaType),
          ),
        ],
      ),
      onTap: () {
        // Handle media drop
        // Replace with actual media drop logic
        onMediaDrop(mediaType, 'example_media_path');
      },
    ));
  }
}

