import 'package:editor/widgets/secondrow/secondparteditor/widget/layer_controll_widget.dart';
import 'package:flutter/material.dart';

class LayerRowWidget extends StatelessWidget {
  final String layerLabel;
  final bool isLocked;
  final bool isVisible;
  final Function(bool) onLockChanged;
  final Function(bool) onVisibilityChanged;
  final Widget content;

  LayerRowWidget({
    required this.layerLabel,
    required this.isLocked,
    required this.isVisible,
    required this.onLockChanged,
    required this.onVisibilityChanged,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayerControlWidget(
          label: layerLabel,
          isLocked: isLocked,
          isVisible: isVisible,
          onLockChanged: onLockChanged,
          onVisibilityChanged: onVisibilityChanged,
        ),
        Container(
          height: 50,
          color: Colors.grey[850],
          child: content,
        ),
      ],
    );
  }
}
