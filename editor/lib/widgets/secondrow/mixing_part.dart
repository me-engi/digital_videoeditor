import 'package:flutter/material.dart';

class TimelineAndLayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10, // Adjust item count based on your needs
            itemBuilder: (context, index) {
              return TimelineItem(
                index: index,
              );
            },
          ),
        ),
        Expanded(
          child: LayerControls(),
        ),
      ],
    );
  }
}

class TimelineItem extends StatelessWidget {
  final int index;

  const TimelineItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.grey[200],
      child: Center(
        child: Text('Item $index'),
      ),
    );
  }
}

class LayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Adjust item count based on your needs
      itemBuilder: (context, index) {
        return LayerItem(
          index: index,
        );
      },
    );
  }
}

class LayerItem extends StatelessWidget {
  final int index;

  const LayerItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: index,
      child: Container(
        height: 50,
        color: Colors.grey[300],
        child: Center(
          child: Text('Layer $index'),
        ),
      ),
      feedback: Container(
        height: 50,
        color: Colors.grey[300],
        child: Center(
          child: Text('Layer $index'),
        ),
      ),
    );
  }
}