import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControls extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const VideoPlayerControls({required this.videoPlayerController});

  @override
  _VideoPlayerControlsState createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed: () {
            // Handle skip previous action
          },
        ),
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            if (widget.videoPlayerController.value.isPlaying) {
              widget.videoPlayerController.pause();
            } else {
              widget.videoPlayerController.play();
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: () {
            // Handle skip next action
          },
        ),
        Expanded(
          child: Slider(
            value: widget.videoPlayerController.value.position.inSeconds.toDouble(),
            max: widget.videoPlayerController.value.duration.inSeconds.toDouble(),
            onChanged: (value) {
              widget.videoPlayerController.seekTo(Duration(seconds: value.toInt()));
            },
          ),
        ),
        Text('${widget.videoPlayerController.value.position.inSeconds}/${widget.videoPlayerController.value.duration.inSeconds}'),
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            // Handle volume adjustment
          },
        ),
      ],
    );
  }
}