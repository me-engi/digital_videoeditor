import 'package:flutter/material.dart';




class EditorTitle extends StatefulWidget {
  final String initialPlayerName;
  final String videoDuration;
  final Function(String) onPlayerNameChanged;

  const EditorTitle({
    Key? key,
    required this.initialPlayerName,
    required this.videoDuration,
    required this.onPlayerNameChanged,
  }) : super(key: key);

  @override
  State<EditorTitle> createState() => _EditorTitleState();
}

class _EditorTitleState extends State<EditorTitle> {
  late TextEditingController _playerNameController;

  @override
  void initState() {
    super.initState();
    _playerNameController = TextEditingController(text: widget.initialPlayerName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Editable player name field
        TextField(
          controller: _playerNameController,
          decoration: InputDecoration(
            labelText: 'Player Name',
            border: OutlineInputBorder(),
          ),
          onChanged: widget.onPlayerNameChanged, // Callback to update player name in parent widget
        ),
        const SizedBox(height: 8),
        // Video duration display
        Text(
          'Video Duration: ${widget.videoDuration}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _playerNameController.dispose();
    super.dispose();
  }
}
