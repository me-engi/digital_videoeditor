import 'package:flutter/material.dart';
class LayerControlWidget extends StatelessWidget {
  final String label;
  final bool isLocked;
  final bool isVisible;
  final Function(bool) onLockChanged;
  final Function(bool) onVisibilityChanged;

  LayerControlWidget({
    required this.label,
    required this.isLocked,
    required this.isVisible,
    required this.onLockChanged,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onVisibilityChanged(!isVisible); // Toggle visibility
          },
          child: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            onLockChanged(!isLocked); // Toggle lock
          },
          child: Icon(
            isLocked ? Icons.lock : Icons.lock_open,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}