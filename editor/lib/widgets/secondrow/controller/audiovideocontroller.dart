import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:js/js_util.dart';
import 'package:path_provider/path_provider.dart'; // Import path_provider for getting directory paths
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
import 'package:editor/widgets/secondrow/controller/js_interop.dart'; 
import 'dart:js' as js;
import 'dart:html' as html;
// Import JS interop

class MediaController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  VideoPlayerController? _videoPlayerController;
  late FFmpeg ffmpeg;

  var isPlaying = false.obs;
  var isPaused = false.obs;
  var volume = 0.5.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;
  var progress = 0.0.obs;

  MediaController(String videoUrl) {
    _initializeVideoController(videoUrl);
    _loadFFmpeg(); // Initialize FFmpeg when MediaController is created
  }

  VideoPlayerController? get videoPlayerController => _videoPlayerController;

  void _initializeVideoController(String url) {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose(); // Dispose of previous controller if it exists
    }

    try {
      _videoPlayerController = VideoPlayerController.network(url)
        ..addListener(() {
          if (_videoPlayerController != null) {
            final isVideoPlaying = _videoPlayerController!.value.isPlaying;
            isPlaying.value = isVideoPlaying;
            isPaused.value = !isVideoPlaying;
            position.value = _videoPlayerController!.value.position;
            duration.value = _videoPlayerController!.value.duration ?? Duration.zero;
            progress.value = _getProgressPercentage();
          }
        })
        ..initialize().then((_) {
          update(); // Ensure UI updates once the video is initialized
        }).catchError((error) {
          print("Error initializing video controller: $error");
        });
    } catch (e) {
      print("Error initializing video controller: $e");
    }
  }

  Future<void> _loadFFmpeg() async {
    try {
      ffmpeg = createFFmpeg();
      await promiseToFuture(loadFFmpeg()); // Convert JSPromise to Future
      print("FFmpeg loaded successfully");
    } catch (e) {
      print("Error loading FFmpeg: $e");
    }
  }

  Future<void> addTextOverlay(String text, String inputVideo, String outputVideo) async {
    try {
      await promiseToFuture(addTextToVideo(inputVideo, text, 10, 10)); // Adjust x and y as needed
      print("Text overlay added successfully");
    } catch (e) {
      print("Error adding text overlay: $e");
    }
  }

  Future<void> addImageOverlay(String imagePath, String inputVideo, String outputVideo, int x, int y) async {
    try {
      await promiseToFuture(overlayImageOnVideo(inputVideo, imagePath, x, y));
      print("Image overlay added successfully");
    } catch (e) {
      print("Error adding image overlay: $e");
    }
  }

  Future<void> trimVideo(String inputVideo, String outputVideo, Duration start, Duration end) async {
    try {
      final command = [
        '-i', inputVideo,
        '-ss', start.inSeconds.toString(),
        '-t', (end - start).inSeconds.toString(),
        '-c', 'copy',
        outputVideo
      ];
      await promiseToFuture(runFFmpeg(ffmpeg, jsify(command)));
      print("Video trimmed successfully from $start to $end");
    } catch (e) {
      print("Error trimming video: $e");
    }
  }

  Future<void> addAudioToVideo(String audioPath, String inputVideo, String outputVideo) async {
    try {
      final command = [
        '-i', inputVideo,
        '-i', audioPath,
        '-c:v', 'copy',
        '-c:a', 'aac',
        '-strict', 'experimental',
        outputVideo
      ];
      await promiseToFuture(runFFmpeg(ffmpeg, jsify(command)));
      print("Audio added to video successfully");
    } catch (e) {
      print("Error adding audio to video: $e");
    }
  }
  Future<String> getTemporaryDirectoryPath() async {
    try {
      final directory = await getTemporaryDirectory();
      return directory.path;
    } on MissingPluginException catch (e) {
      print('Plugin error: $e');
      return '';
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

Future<void> extractFramesFromVideo(String fileUrl, int fps) async {
  final jsFunction = js.context['extractFramesFromVideo'];
  if (jsFunction != null) {
    try {
      final frames = await jsFunction.callMethod('extractFramesFromVideo', [fileUrl, fps]);
      print('Extracted frames: $frames');
      // Handle the extracted frames
    } catch (e) {
      print('Error extracting frames: $e');
    }
  } else {
    print('JavaScript function not found.');
  }
}


  Future<void> stretchVideo(String inputVideo, String outputVideo, Duration newDuration) async {
    try {
      final inputDuration = _videoPlayerController?.value.duration ?? Duration.zero;
      final speed = inputDuration.inMilliseconds / newDuration.inMilliseconds;
      final command = [
        '-i', inputVideo,
        '-filter:v', 'setpts=${1 / speed}*PTS',
        '-c:a', 'atempo=$speed',
        outputVideo
      ];
      await promiseToFuture(runFFmpeg(ffmpeg, jsify(command)));
      print("Video stretched successfully to $newDuration");
    } catch (e) {
      print("Error stretching video: $e");
    }
  }

  void play(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      _videoPlayerController?.dispose(); // Dispose of the old controller if it exists
      _initializeVideoController(url);
      _videoPlayerController?.play();
      _audioPlayer.play();
      isPlaying.value = true; // Update observable
      isPaused.value = false; // Update observable
    } catch (e) {
      print("Error playing media: $e");
    }
  }

  void pause() {
    _audioPlayer.pause();
    _videoPlayerController?.pause();
    isPlaying.value = false; // Update observable
    isPaused.value = true; // Update observable
  }

  void forward() {
    _seekBy(Duration(seconds: 10));
  }

  void backward() {
    _seekBy(Duration(seconds: -10));
  }

  void _seekBy(Duration offset) {
    final newPosition = _audioPlayer.position + offset;
    final maxPosition = _audioPlayer.duration ?? Duration.zero;

    if (newPosition < Duration.zero) {
      _audioPlayer.seek(Duration.zero);
      _videoPlayerController?.seekTo(Duration.zero);
    } else if (newPosition > maxPosition) {
      _audioPlayer.seek(maxPosition);
      _videoPlayerController?.seekTo(maxPosition);
    } else {
      _audioPlayer.seek(newPosition);
      _videoPlayerController?.seekTo(newPosition);
    }
    position.value = newPosition; // Update observable
  }

  void repeat() {
    _audioPlayer.setLoopMode(LoopMode.one);
    if (_videoPlayerController != null) {
      _videoPlayerController!.setLooping(!_videoPlayerController!.value.isLooping);
    }
  }

  void adjustVolume(double newVolume) {
    _audioPlayer.setVolume(newVolume);
    volume.value = newVolume; // Update observable
  }

  void seekTo(int milliseconds) {
    final newPosition = Duration(milliseconds: milliseconds);
    _audioPlayer.seek(newPosition);
    _videoPlayerController?.seekTo(newPosition);
    position.value = newPosition; // Update observable
  }

  double _getProgressPercentage() {
    if (duration.value.inMilliseconds == 0) return 0.0;
    return position.value.inMilliseconds / duration.value.inMilliseconds;
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    _videoPlayerController?.dispose();
    super.onClose();
  }
}
