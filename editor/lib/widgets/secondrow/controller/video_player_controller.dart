import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  final VideoPlayerController _videoPlayerController;
  
  var isPlaying = false.obs;
  var isPaused = false.obs;
  var volume = 0.5.obs;  // Volume range is typically between 0.0 and 1.0
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;
  var progress = 0.0.obs;  // Observable to track progress percentage

  VideoController(String url) : _videoPlayerController = VideoPlayerController.network(url);

  @override
  void onInit() {
    super.onInit();

    // Initialize the video player
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.hasError) {
        print("Video player error: ${_videoPlayerController.value.errorDescription}");
      }

      isPlaying.value = _videoPlayerController.value.isPlaying;
      isPaused.value = !_videoPlayerController.value.isPlaying;
      position.value = _videoPlayerController.value.position;
      duration.value = _videoPlayerController.value.duration;
      progress.value = getProgressPercentage();  // Update progress
    });

    _videoPlayerController.initialize().then((_) {
      // Ensure the controller is properly initialized and ready to play
      update();  // Notify listeners
    });
  }

  void play() {
    _videoPlayerController.play();
  }

  void pause() {
    _videoPlayerController.pause();
  }

  void forward() {
    final currentPosition = _videoPlayerController.value.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    final maxPosition = _videoPlayerController.value.duration;

    if (newPosition < maxPosition) {
      _videoPlayerController.seekTo(newPosition);
    } else {
      _videoPlayerController.seekTo(maxPosition);
    }
  }

  void backward() {
    final currentPosition = _videoPlayerController.value.position;
    final newPosition = currentPosition - Duration(seconds: 10);

    if (newPosition > Duration.zero) {
      _videoPlayerController.seekTo(newPosition);
    } else {
      _videoPlayerController.seekTo(Duration.zero);
    }
  }

  void repeat() {
    // Looping is managed by setting videoPlayerController to repeat
    _videoPlayerController.setLooping(!_videoPlayerController.value.isLooping);
  }

  void adjustVolume(double newVolume) {
    // The video_player package does not provide volume control.
    // If you need volume control, consider using another video player package.
    volume.value = newVolume;
  }

  void seekTo(int milliseconds) {
    _videoPlayerController.seekTo(Duration(milliseconds: milliseconds));
  }

  double getProgressPercentage() {
    if (duration.value.inMilliseconds == 0) return 0.0;
    return position.value.inMilliseconds / duration.value.inMilliseconds;
  }

  @override
  void onClose() {
    _videoPlayerController.dispose();  // Properly dispose of the video player when the controller is destroyed
    super.onClose();
  }
}
