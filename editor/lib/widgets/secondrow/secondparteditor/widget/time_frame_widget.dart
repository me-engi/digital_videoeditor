import 'package:editor/constants/colors.dart'; // Update with correct import path
import 'package:editor/constants/text_theme.dart'; // Update with correct import path
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = getTextTheme(); // Assuming you have a method to get the text theme

    return Container(
      width: double.infinity, // Make the container take full width
      height: 20.h, // Adjust height for responsiveness
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List.generate(11, (index) {
            // Generate 11 time labels (0s to 50s)
            final time = '${index * 5}s'; // '0s', '5s', '10s', etc.
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w), // Responsive padding
              child: Text(
                time,
                style: textTheme.bodySmall?.copyWith(
                  color: ConstColors.white,
                  fontSize: 10.sp, // Responsive font size
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
