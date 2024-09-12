// import 'package:flutter/material.dart';

// class WidgetsDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             child: Text('Widgets', style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           DropdownButtonListTile(
//             title: 'Basic',
//             value: Icons.brightness_high, // Default value
//             items: [
//               DropdownMenuItem(value: Icons.brightness_high, child: Icon(Icons.brightness_high)),
//               DropdownMenuItem(value: Icons.crop_square, child: Icon(Icons.crop_square)),
//               // ... other basic widgets
//             ],
//           ),
//           DropdownButtonListTile(
//             title: 'Media',
//             value: Icons.grid_on, // Default value
//             items: [
//               DropdownMenuItem(value: Icons.grid_on, child: Icon(Icons.grid_on)),
//               DropdownMenuItem(value: Icons.image_aspect_ratio, child: Icon(Icons.image_aspect_ratio)),
//               // ... other media widgets
//             ],
//           ),
//           // Add more dropdown buttons and list items as needed
//         ],
//       ),
//     );
//   }
// }

// class DropdownButtonListTile extends StatefulWidget {
//   final String title;
//   final Icon value;
//   final List<DropdownMenuItem<Icon>> items;

//   const DropdownButtonListTile({
//     required this.title,
//     required this.value,
//     required this.items,
//   });

//   @override
//   _DropdownButtonListTileState createState() => _DropdownButtonListTileState();
// }

// class _DropdownButtonListTileState extends State<DropdownButtonListTile> {
//   late Icon _currentValue;

//   @override
//   void initState() {
//     super.initState();
//     _currentValue = widget.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(widget.title),
//       trailing: DropdownButton<Icon>(
//         value: _currentValue,
//         items: widget.items,
//         onChanged: (value) {
//           if (value != null) {
//             setState(() {
//               _currentValue = value;
//             });
//           }
//         },
//       ),
//     );
//   }
// }
