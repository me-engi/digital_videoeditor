import 'package:flutter/material.dart';

class PlaylistNameDurationWidget extends StatelessWidget {
  final TextEditingController playlistNameController;
  final String duration;

  PlaylistNameDurationWidget({
    required this.playlistNameController,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: playlistNameController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter Playlist Name',
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Text(
          duration,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
