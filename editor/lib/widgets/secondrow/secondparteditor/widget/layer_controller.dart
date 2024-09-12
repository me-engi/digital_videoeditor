import 'dart:io';
import 'dart:typed_data';
import 'package:editor/widgets/secondrow/controller/audiovideocontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

enum MediaType {
  video,
  audio,
  document,
  pdf,
  image,
}

class LayerController extends GetxController {
  var layers = <LayerData>[
    LayerData(label: 'V1', isLocked: false, isVisible: true, mediaType: MediaType.video),
    LayerData(label: 'V2', isLocked: false, isVisible: true, mediaType: MediaType.video),
    LayerData(label: 'A1', isLocked: true, isVisible: false, mediaType: MediaType.audio),
    LayerData(label: 'A2', isLocked: true, isVisible: false, mediaType: MediaType.audio),
  ].obs;

  late Box mediaBox;
  late Box layersBox;

  DropzoneViewController? dropzoneController;
  RxString dropzoneMessage = 'Drag media here'.obs;
  RxBool isHighlighted = false.obs;

  @override
  void onInit() {
    super.onInit();
    mediaBox = Hive.box('mediaBox');
    layersBox = Hive.box('layersBox');
    loadLayersFromHive();
  }

  void loadLayersFromHive() {
    final savedLayers = layersBox.get('layersData') as List<dynamic>?;
    if (savedLayers != null) {
      layers.value = savedLayers.map((e) {
        if (e is Map) {
          return LayerData.fromJson(Map<String, dynamic>.from(e));
        }
        throw Exception('Invalid data format');
      }).toList();
    }
  }

  void saveLayersToHive() {
    layersBox.put('layersData', layers.map((e) => e.toJson()).toList());
  }

  void toggleLock(int index) {
    layers[index].isLocked = !layers[index].isLocked;
    layers.refresh();
    saveLayersToHive();
  }

  void toggleVisibility(int index) {
    layers[index].isVisible = !layers[index].isVisible;
    layers.refresh();
    saveLayersToHive();
  }

  void handleDrop(int index, MediaType mediaType, dynamic event) async {
    final fileName = await dropzoneController?.getFilename(event);
    final fileBytes = await dropzoneController?.getFileData(event);

    if (fileBytes != null) {
      final layerLabel = layers[index].label;

      try {
        // Save the file to Hive immediately after dropping
        saveFileToHive(fileBytes, fileName!, layerLabel);

        // Fetch the file from Hive and display it
        final savedFile = fetchFileFromHive(layerLabel);
        if (savedFile != null) {
          if (mediaType == MediaType.video) {
            // Extract a frame from the video and save it
            final frameImage = await extractFrameFromVideo(savedFile['file'], 0);
            if (frameImage != null) {
              // Save the frame to Hive
              saveFrameToHive(frameImage, layerLabel);
              // Update the layer with the frame
              updateLayerWithFrame(layerLabel, frameImage);
            } else {
              dropzoneMessage.value = 'Failed to extract frame from video';
            }
          } else {
            // Handle other media types
            updateLayerWithFile(mediaType, savedFile['name']);
          }
        } else {
          dropzoneMessage.value = 'Failed to fetch file from Hive';
        }
      } catch (e) {
        dropzoneMessage.value = 'Error handling file: $e';
        print('Error handling file: $e');
      }

      dropzoneMessage.value = 'File dropped: $fileName';
      print('Dropped $mediaType on ${layers[index].label}');
    }
  }

  Map<String, dynamic>? fetchFileFromHive(String layerLabel) {
    final fileData = mediaBox.get(layerLabel);
    if (fileData != null) {
      print('Fetched file from Hive: ${fileData['name']}');
      return fileData;
    }
    print('No file found for key: $layerLabel');
    return null;
  }

  void saveFileToHive(Uint8List file, String fileName, String layerLabel) {
    final key = layerLabel;
    final data = {'file': file, 'name': fileName};
    mediaBox.put(key, data);
    print('File saved to Hive with key $key');
  }

  void saveFrameToHive(Uint8List frame, String layerLabel) {
    final key = '${layerLabel}_frame';
    mediaBox.put(key, frame);
    print('Frame saved to Hive with key $key');
  }

  Future<Uint8List?> extractFrameFromVideo(Uint8List videoBytes, int timeInSeconds) async {
    final tempDir = await getTemporaryDirectory();
    final tempVideoFile = File('${tempDir.path}/video_temp.mp4');
    await tempVideoFile.writeAsBytes(videoBytes);

    final outputFramePath = '${tempDir.path}/frame.png';
    try {
      // Implement actual frame extraction logic using ffmpeg or similar
      // Placeholder for frame extraction logic
      await Future.delayed(Duration(seconds: 2));
      print('Frame extracted at $timeInSeconds seconds');
      return Uint8List.fromList([]); // Replace with actual frame bytes
    } catch (e) {
      print('Error extracting frame: $e');
      return null;
    } finally {
      tempVideoFile.delete();
    }
  }

  void updateLayerWithFrame(String layerLabel, Uint8List frame) {
    final layer = layers.firstWhere((l) => l.label == layerLabel);
    layer.frameData = frame; // Add this field to LayerData
    layers.refresh();
  }

  void updateLayerWithFile(MediaType mediaType, String fileName) {
    final layer = layers.firstWhere((l) => l.mediaType == mediaType && l.isVisible);
    layer.fileName = fileName; // Add this field to LayerData
    layers.refresh();
  }

  void displayFrame(String layerLabel) {
    final frameKey = '${layerLabel}_frame';
    final frameData = mediaBox.get(frameKey);
    if (frameData != null) {
      final frameImage = Image.memory(frameData);
      // Display the image in the corresponding layer
      print('Displaying frame for $layerLabel');
      // Add logic to display the image in your UI
    } else {
      print('No frame found for key: $frameKey');
    }
  }

  void displayFile(MediaType mediaType, String fileName) {
    if (mediaType == MediaType.video) {
      print('Playing video: $fileName');
      // Display the video using video player
    } else if (mediaType == MediaType.audio) {
      print('Playing audio: $fileName');
      // Display the audio using audio player
    } else if (mediaType == MediaType.image) {
      print('Displaying image: $fileName');
      // Display the image
    } else if (mediaType == MediaType.pdf || mediaType == MediaType.document) {
      print('Displaying document: $fileName');
      // Display the document
    }
  }

  void setHighlight(bool highlight) {
    isHighlighted.value = highlight;
  }
}

class LayerData {
  String label;
  bool isLocked;
  bool isVisible;
  MediaType mediaType;
  Uint8List? frameData; // Add this field to hold frame data
  String? fileName; // Add this field to hold file name

  LayerData({
    required this.label,
    required this.isLocked,
    required this.isVisible,
    required this.mediaType,
    this.frameData,
    this.fileName,
  });

  factory LayerData.fromJson(Map<String, dynamic> json) {
    return LayerData(
      label: json['label'],
      isLocked: json['isLocked'],
      isVisible: json['isVisible'],
      mediaType: MediaType.values.firstWhere((e) => e.toString() == json['mediaType']),
      frameData: json['frameData'] != null ? Uint8List.fromList(json['frameData']) : null,
      fileName: json['fileName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'isLocked': isLocked,
      'isVisible': isVisible,
      'mediaType': mediaType.toString(),
      'frameData': frameData?.toList(),
      'fileName': fileName,
    };
  }
}


class LayerScreen extends StatelessWidget {
  final LayerController layerController = Get.put(LayerController());
  final MediaController mediaController = Get.put(MediaController('')); // Initialize with a default URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Layer Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => ListView.builder(
            itemCount: layerController.layers.length,
            itemBuilder: (context, index) {
              final layer = layerController.layers[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(layer.label, style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: Icon(
                          layer.isLocked ? Icons.lock : Icons.lock_open,
                          color: layer.isLocked ? Colors.red : Colors.green,
                        ),
                        onPressed: () {
                          layerController.toggleLock(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          layer.isVisible ? Icons.visibility : Icons.visibility_off,
                          color: layer.isVisible ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          layerController.toggleVisibility(index);
                        },
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                layerController.dropzoneMessage.value,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Positioned.fill(
                              child: DropzoneView(
                                onCreated: (controller) {
                                  layerController.dropzoneController = controller;
                                  print('DropzoneController created');
                                },
                                onDrop: (event) {
                                  print('File dropped event received');
                                  // Handle file drop
                                  layerController.handleDrop(index, layer.mediaType, event);

                                  // Use mediaController for frame extraction if it's a video
                                  if (layer.mediaType == 'video') {
                                    final videoUrl = 'URL_to_the_dropped_video'; // Replace with actual URL
                                    mediaController.play(videoUrl); // Start playing the video

                                    // Example: Extract a frame from the video at 10 seconds
                                    mediaController.extractFramesFromVideo(videoUrl,  5).then((path) {
                                      // Do something with the extracted frame path
                                    });
                                  }
                                },
                                onHover: () {
                                  print('Hover detected');
                                  layerController.setHighlight(true);
                                },
                                onLeave: () {
                                  print('Hover left');
                                  layerController.setHighlight(false);
                                },
                              ),
                            ),
                            if (layer.isVisible)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    layer.label,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Media controller class to handle video stretching (example implementation)

// 
