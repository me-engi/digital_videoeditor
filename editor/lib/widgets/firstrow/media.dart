import 'package:editor/widgets/firstrow/controller/media_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Import for SVG support
import 'package:get/get.dart';

class MediaSection extends StatefulWidget {
  @override
  _MediaSectionState createState() => _MediaSectionState();
}

class _MediaSectionState extends State<MediaSection> {
  final Mediacontroller _mediaController = Get.put(Mediacontroller());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Obx(() => Container(
                color: _mediaController.isHighlighted.value
                    ? Colors.blue[800]
                    : Colors.grey[800],
                width: double.infinity,
                height: 200,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        _mediaController.dropzoneMessage.value,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DropzoneView(
                      onCreated: (controller) =>
                          _mediaController.dropzoneController = controller,
                      onDrop: _mediaController.handleFile,
                      onHover: () => _mediaController.setHighlight(true),
                      onLeave: () => _mediaController.setHighlight(false),
                    ),
                  ],
                ),
              )),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIconButton(
                'assets/icons/draganddrop/video.svg',
                'Upload Video',
                FileType.video,
              ),
              SizedBox(width: 16.0),
              _buildIconButton(
                'assets/icons/draganddrop/gallary.svg', // Ensure correct path
                'Upload Photo',
                FileType.image,
              ),
              SizedBox(width: 16.0),
              _buildIconButton(
                'assets/icons/draganddrop/document.svg',
                'Upload PDF',
                FileType.custom,
                allowedExtensions: ['pdf'],
              ),
              SizedBox(width: 16.0),
              _buildIconButton(
                'assets/icons/draganddrop/audio.svg',
                'Upload Audio',
                FileType.custom,
                allowedExtensions: ['mp3', 'wav'],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
    String iconPath,
    String label,
    FileType type, {
    List<String>? allowedExtensions,
  }) {
    return GestureDetector(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: type,
          allowedExtensions: allowedExtensions,
        );

        if (result != null) {
          final file = result.files.single;
          await _mediaController.handleFilePicker(file);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 40,
                height: 40,
                color: Colors.blueAccent,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
