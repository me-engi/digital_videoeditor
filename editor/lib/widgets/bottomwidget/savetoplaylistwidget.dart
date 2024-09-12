import 'package:flutter/material.dart';

class BottomControlBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle previous action
          },
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            // Handle next action
          },
        ),
        Expanded(
          child: Slider(
            value: 0.5, // Adjust initial value
            onChanged: (value) {
              // Handle slider value change
            },
          ),
        ),
        Text('00.00.30.02 / 00.00.28.00'),
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            // Handle volume adjustment
          },
        ),
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            // Handle save action
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Handle delete action
          },
        ),
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            // Handle play/pause action
          },
        ),
      ],
    );
  }
}