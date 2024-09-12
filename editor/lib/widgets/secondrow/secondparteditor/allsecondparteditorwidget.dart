import 'package:editor/constants/colors.dart';
import 'package:editor/widgets/secondrow/secondparteditor/widget/layer_controller.dart';
import 'package:editor/widgets/secondrow/secondparteditor/widget/widget_for_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SecondPartCombinedWidget extends StatefulWidget {
  const SecondPartCombinedWidget({super.key});

  @override
  State<SecondPartCombinedWidget> createState() => _SecondPartCombinedWidgetState();
}

class _SecondPartCombinedWidgetState extends State<SecondPartCombinedWidget> {
  String playerName = 'Player 1'; // Default player name
  String videoDuration = ''; // Initially, no video duration

  final LayerController layerController = Get.put(LayerController());

  @override
  void initState() {
    super.initState();
    // Load initial data from Hive
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    // Ensure Hive boxes are open
    if (!Hive.isBoxOpen('media')) await Hive.openBox('media');
    if (!Hive.isBoxOpen('layers')) await Hive.openBox('layers');

    // Load layers from Hive if needed
    final box = Hive.box('layers');
    final savedLayers = box.get('layersData') as List<dynamic>?;

    if (savedLayers != null) {
      layerController.layers.value = savedLayers.map((e) => LayerData.fromJson(e)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // EditorTitle Widget
            EditorTitle(
              initialPlayerName: playerName,
              videoDuration: videoDuration.isEmpty ? 'No video yet' : videoDuration,
              onPlayerNameChanged: (newName) {
                setState(() {
                  playerName = newName; // Update player name when edited
                });
              },
            ),
            const SizedBox(height: 16),

            // Drag-and-drop area for video
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: DragTarget<String>(
                onAccept: (mediaPath) {
                  // Assume media type based on filename
                  if (mediaPath.endsWith('.mp4')) {
                    setState(() {
                      videoDuration = '30s'; // Update video duration
                    });
                  } else if (mediaPath.endsWith('.mp3')) {
                    // Handle audio drop if needed
                  }
                },
                builder: (context, candidateData, rejectedData) {
                  return Center(
                    child: Text(
                      'Drag and drop a video or audio file here',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // LayerScreen Widget
            Expanded(
              child: LayerScreen(),
            ),
          ],
        ),
      ),
    );
  }
}