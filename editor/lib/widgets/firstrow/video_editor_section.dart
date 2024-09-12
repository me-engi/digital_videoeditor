import 'package:editor/widgets/firstrow/composition.dart';
import 'package:editor/widgets/firstrow/layout_scetion.dart';
import 'package:editor/widgets/firstrow/media.dart';
import 'package:flutter/material.dart';


class VideoEditorSection extends StatefulWidget {
  @override
  _VideoEditorSectionState createState() => _VideoEditorSectionState();
}

class _VideoEditorSectionState extends State<VideoEditorSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Layouts'),
          LayoutsSection(),
          Divider(color: Colors.white54),
          _buildSectionTitle('Composition'),
          CompositionSection(),
          Divider(color: Colors.white54),
          _buildSectionTitle('Media'),
          MediaSection(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
