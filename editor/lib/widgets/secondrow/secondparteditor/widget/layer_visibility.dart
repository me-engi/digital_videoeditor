import 'package:flutter/material.dart';

class LayerVisibilityControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Layer Visibility Controls", style: Theme.of(context).textTheme.titleLarge),
        // Add controls for layer visibility here
        // For example, toggles or switches for layer visibility
        SwitchListTile(
          title: Text("Show V1"),
          value: true, // Replace with actual state
          onChanged: (bool value) {
            // Handle visibility toggle for V1
          },
        ),
        SwitchListTile(
          title: Text("Show V2"),
          value: true, // Replace with actual state
          onChanged: (bool value) {
            // Handle visibility toggle for V2
          },
        ),
        SwitchListTile(
          title: Text("Show V3"),
          value: true, // Replace with actual state
          onChanged: (bool value) {
            // Handle visibility toggle for V3
          },
        ),
        // Repeat for audio layers or other controls
      ],
    );
  }
}
