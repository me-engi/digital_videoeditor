import 'package:flutter/material.dart';

class Frame100 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 380,
          height: 124,
          padding: const EdgeInsets.all(20),
          decoration: ShapeDecoration(
            color: Color(0xFF262626),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFF2D3142)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 203,
                height: 84,
                padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 32),
                decoration: ShapeDecoration(
                  color: Color(0xFF2D3142),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Single zone',
                      style: TextStyle(
                        color: Color(0xFFF0FBFF),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0.11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dimensions: 1920x1080',
                      style: TextStyle(
                        color: Color(0xFFB5B7C0),
                        fontSize: 8,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.21,
                      ),
                    ),
                    Text(
                      'Orientation: Landscape',
                      style: TextStyle(
                        color: Color(0xFFB5B7C0),
                        fontSize: 8,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.21,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Duration: 00.00.30.02',
                      style: TextStyle(
                        color: Color(0xFFF0FBFF),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
