import 'package:flutter/material.dart';

class ProgressLevelCircle extends StatelessWidget {
  final int points; // User's points

  const ProgressLevelCircle({required this.points, super.key});

  @override
  Widget build(BuildContext context) {
    int level = points ~/ 100; // Integer division to calculate the level
    double progress =
        (points % 100) / 100; // Fractional part of points for progress

    return SizedBox(
      width: 40, // Circle size
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              backgroundColor: Colors.transparent,
            ),
          ),
          Text(
            "$level",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'SansitaOne',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
