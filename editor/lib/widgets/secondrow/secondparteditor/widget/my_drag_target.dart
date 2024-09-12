import 'package:flutter/material.dart';

class MyDragTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: (data) {
        // Handle the accepted data
        print('Accepted data: $data');
      },
      builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
        return Container(
          height: 100,
          width: 100,
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              'Drag here',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
