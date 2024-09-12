import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CompositionSection extends StatefulWidget {
  @override
  _CompositionSectionState createState() => _CompositionSectionState();
}

class _CompositionSectionState extends State<CompositionSection> {
  final Box compositionsBox = Hive.box('compositions');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: compositionsBox.listenable(),
        builder: (context, Box box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final composition = box.getAt(index) as Map?;
              if (composition != null) {
                final type = composition['type'];
                final data = composition['data'];
                final displayText = type == 'text'
                    ? data
                    : type == 'web'
                        ? 'Web file (base64 data)'
                        : 'File: ${composition['path']}';
                return ListTile(
                  title: Text(
                    displayText ?? 'No data',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return ListTile(
                  title: Text('No data', style: TextStyle(color: Colors.white)),
                );
              }
            },
          );
        },
      ),
    );
  }
}
