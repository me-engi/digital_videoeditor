import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LayoutsSection extends StatefulWidget {
  @override
  _LayoutsSectionState createState() => _LayoutsSectionState();
}

class _LayoutsSectionState extends State<LayoutsSection> {
  final Box layoutsBox = Hive.box('layouts');

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _buildLayoutOption('Single Zone', 'single_zone'),
        _buildLayoutOption('Two Zone', 'two_zone'),
        _buildLayoutOption('Three Zone', 'three_zone'),
      ],
    );
  }

  Widget _buildLayoutOption(String title, String key) {
    return ListTile(
      leading: Checkbox(
        value: layoutsBox.get(key, defaultValue: false),
        onChanged: (bool? value) {
          setState(() {
            layoutsBox.put(key, value);
          });
        },
      ),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
      onTap: () {
        // Navigate to the layout management popup
      },
    );
  }
}
