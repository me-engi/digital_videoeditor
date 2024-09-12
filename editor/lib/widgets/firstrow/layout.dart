import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Layouts', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                ),
                SizedBox(width: 8), // Adds spacing between icons
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add), // "+" button for adding
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(value: true, onChanged: (value) {}),
            SizedBox(width: 8), // Adds spacing between checkbox and text
            Expanded(
              child: Text('Single Zone'),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
            ),
          ],
          
        ),
        Row(
          children: [
            Checkbox(value: true, onChanged: (value) {}),
            SizedBox(width: 8), // Adds spacing between checkbox and text
            Expanded(
              child: Text('Single Zone'),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
            ),
          ],
          
        ),
        Row(
          children: [
            Checkbox(value: true, onChanged: (value) {}),
            SizedBox(width: 8), // Adds spacing between checkbox and text
            Expanded(
              child: Text('Single Zone'),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
            ),
          ],
          
        ),
        Row(
          children: [
            Checkbox(value: true, onChanged: (value) {}),
            SizedBox(width: 8), // Adds spacing between checkbox and text
            Expanded(
              child: Text('Single Zone'),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
            ),
          ],
          
        ),

      ],
    );
  }
}



// import 'package:flutter/material.dart';

// class LayoutsSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Layouts', style: TextStyle(fontWeight: FontWeight.bold)),
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     // Handle edit action
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     // Handle add action
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//         ListTile(
//           leading: Checkbox(
//             value: true, // Adjust initial value
//             onChanged: (value) {
//               // Handle checkbox change
//             },
//           ),
//           title: Text('Single zone'),
//           subtitle: Text('Dimensions: 1920x1080'),
//           trailing: DropdownButton<String>(
//             value: 'Single Zone', // Adjust initial value
//             items: <String>['Single Zone', 'Two Zone'].map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             onChanged: (value) {
//               // Handle dropdown change
//             },
//           ),
//         ),
//         // Add more ListTile widgets for other layout options
//       ],
//     );
//   }
// }