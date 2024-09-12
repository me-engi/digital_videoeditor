import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();  // Initialize the audio player

  var isPlaying = false.obs;
  var isPaused = false.obs;
  var volume = 0.5.obs;  // Volume range is typically between 0.0 and 1.0
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;
  var progress = 0.0.obs;  // Observable to track progress percentage

  @override
  void onInit() {
    super.onInit();

    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      isPaused.value = !state.playing;
    });

    // Listen to position changes
    _audioPlayer.positionStream.listen((newPosition) {
      position.value = newPosition;
      progress.value = getProgressPercentage();  // Update progress
    });

    // Listen to duration changes
    _audioPlayer.durationStream.listen((newDuration) {
      duration.value = newDuration ?? Duration.zero;
    });
  }

  void play(String url, {required bool isLocal}) async {
    try {
      await _audioPlayer.setUrl(url); // Load the audio source from the URL
      _audioPlayer.play(); // Start playing
    } catch (e) {
      // Handle any errors that occur during the loading process
      print("Error playing audio: $e");
    }
  }

  void pause() {
    _audioPlayer.pause();
  }

  void forward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    final maxPosition = _audioPlayer.duration ?? Duration.zero;

    if (newPosition < maxPosition) {
      _audioPlayer.seek(newPosition);
    } else {
      _audioPlayer.seek(maxPosition);
    }
  }

  void backward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition - Duration(seconds: 10);

    if (newPosition > Duration.zero) {
      _audioPlayer.seek(newPosition);
    } else {
      _audioPlayer.seek(Duration.zero);
    }
  }

  void repeat() {
    _audioPlayer.setLoopMode(LoopMode.one);  // Set the player to repeat the current track
  }

  void adjustVolume(double newVolume) {
    _audioPlayer.setVolume(newVolume);  // Set volume between 0.0 and 1.0
    volume.value = newVolume;
  }

  void tenSec() {
    final currentPosition = _audioPlayer.position;
    _audioPlayer.seek(currentPosition + Duration(seconds: 10));
  }

  void increment() {
    adjustVolume((volume.value + 0.1).clamp(0.0, 1.0));
  }

  void decrement() {
    adjustVolume((volume.value - 0.1).clamp(0.0, 1.0));
  }

  void seekTo(int milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
  }

  double getProgressPercentage() {
    if (duration.value.inMilliseconds == 0) return 0.0;
    return position.value.inMilliseconds / duration.value.inMilliseconds;
  }

  @override
  void onClose() {
    _audioPlayer.dispose();  // Properly dispose of the audio player when the controller is destroyed
    super.onClose();
  }
}
