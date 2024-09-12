import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:io' as io; // Import only for non-web platforms
import 'package:file_picker/file_picker.dart'; // Import for file_picker

class Mediacontroller extends GetxController {
  final dropzoneMessage = 'Drop something here'.obs;
  final isHighlighted = false.obs;
  late DropzoneViewController dropzoneController;

  // Access the compositions box
  Box get compositionsBox => Hive.box('compositions');

  void setHighlight(bool highlight) {
    isHighlighted.value = highlight;
  }

  void setDropzoneMessage(String message) {
    dropzoneMessage.value = message;
  }

  Future<void> handleFile(dynamic event) async {
    if (kIsWeb) {
      // Web-specific handling
      if (event is Uint8List) {
        final base64Data = base64Encode(event);
        print('File dropped (web)');
        setDropzoneMessage('File dropped');
        print(base64Data.substring(0, min(base64Data.length, 20)));
        // Store base64 data
        await compositionsBox.add({
          'type': 'web',
          'data': base64Data,
        });
      } else if (event is String) {
        print('Text dropped: $event');
        setDropzoneMessage('Text dropped');
        print(event.substring(0, min(event.length, 20)));
        // Store text data
        await compositionsBox.add({
          'type': 'text',
          'data': event,
        });
      } else {
        print('Unknown drop type: ${event.runtimeType}');
      }
    } else {
      // Non-web platforms
      if (event is io.File) {
        final bytes = await event.readAsBytes();
        final filePath = event.path ?? 'Unknown Path';
        print('File dropped (non-web): $filePath');
        setDropzoneMessage('File dropped');
        print(bytes.sublist(0, min(bytes.length, 20)));
        // Store file metadata and data
        await compositionsBox.add({
          'type': 'file',
          'path': filePath,
          'data': base64Encode(bytes), // Encode bytes as base64
        });
      } else {
        print('Unknown drop type: ${event.runtimeType}');
      }
    }
    setHighlight(false);
  }

  Future<void> handleFilePicker(PlatformFile file) async {
    if (kIsWeb) {
      final bytes = file.bytes;
      if (bytes != null) {
        final base64Data = base64Encode(bytes);
        print('File picked (web)');
        setDropzoneMessage('File picked');
        print(base64Data.substring(0, min(base64Data.length, 20)));
        // Store base64 data
        await compositionsBox.add({
          'type': 'web',
          'data': base64Data,
        });
      }
    } else {
      final filePath = file.path ?? 'Unknown Path';
      print('File picked (non-web): $filePath');
      setDropzoneMessage('File picked');
      // Store file metadata and data
      await compositionsBox.add({
        'type': 'file',
        'path': filePath,
        'data': base64Encode(file.bytes ?? Uint8List(0)), // Encode bytes as base64
      });
    }
  }
}
