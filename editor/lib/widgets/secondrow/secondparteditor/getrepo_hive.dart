import 'package:hive/hive.dart';
import 'dart:io';

Future<File> getVideoFileFromHive(String videoKey) async {
  try {
    // Open the Hive box
    var box = await Hive.openBox('mediaBox'); // Replace 'mediaBox' with your actual box name

    // Retrieve the file path or byte data from Hive
    var videoPath = box.get(videoKey);
    if (videoPath == null) {
      throw Exception('Video not found in Hive with key $videoKey');
    }

    // Create a File object from the path or byte data
    return File(videoPath); // If stored as a path
    // return File.fromRawPath(videoPath); // If stored as byte data
  } catch (e) {
    print("Error retrieving video from Hive: $e");
    rethrow;
  }
}
