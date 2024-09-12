import 'dart:js_interop';

// JS Interop for FFmpeg functions
@JS('window.ffmpegInterop.loadFFmpeg')
external JSPromise loadFFmpeg();  // JavaScript function to load FFmpeg

@JS('window.ffmpegInterop.runFFmpeg')
external JSPromise runFFmpeg(FFmpeg ffmpeg, JSArray command);  // JavaScript function to run FFmpeg command

@JS('window.ffmpegInterop.cropVideo')
external JSPromise cropVideo(String inputFile, int width, int height, int x, int y);

@JS('window.ffmpegInterop.addTextToVideo')
external JSPromise addTextToVideo(String inputFile, String text, int x, int y);

@JS('window.ffmpegInterop.overlayImageOnVideo')
external JSPromise overlayImageOnVideo(String inputFile, String imageFile, int x, int y);

@JS('window.ffmpegInterop.adjustAudioVolume')
external JSPromise adjustAudioVolume(String inputFile, double volume);

@JS('window.ffmpegInterop.extractFramesFromVideo')
external JSPromise extractFramesFromVideo(String inputFile, [int fps = 1]);

@JS('FFmpeg')
@staticInterop
class FFmpeg {
  external factory FFmpeg();
}

@JS('createFFmpeg')
external FFmpeg createFFmpeg();