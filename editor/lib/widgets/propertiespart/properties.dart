import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PropertiesPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust width as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Properties', style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(
            title: Text('Text'),
            subtitle: DropdownButton<String>(
              value: 'Inter',
              items: <String>['Inter', 'Roboto', 'Arial'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                // Handle font change
              },
            ),
          ),
          ListTile(
            title: Text('Case'),
            subtitle: DropdownButton<String>(
              value: 'Left',
              items: <String>['Left', 'Right', 'Center'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                // Handle case change
              },
            ),
          ),
          ListTile(
            title: Text('Styling'),
            subtitle: ColorPicker(
              pickerColor: Colors.green,
              onColorChanged: (color) {
                // Handle color change
              },
            ),
          ),
          Divider(),
          Text('Layers', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Adjust item count based on your needs
              itemBuilder: (context, index) {
                return LayerListItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LayerListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.check),
      title: Text('xyz'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.lock),
            onPressed: () {
              // Handle lock/unlock
            },
          ),
          IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              // Handle visibility
            },
          ),
          DropdownButton<String>(
            value: 'Normal',
            items: <String>['Normal', 'Multiply', 'Screen'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              // Handle blend mode change
            },
          ),
        ],
      ),
    );
  }
}