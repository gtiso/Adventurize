import 'package:flutter/material.dart';

class ProgressLevelCircle extends StatelessWidget {
  final double progress; // Progress between 0.0 and 1.0
  final int level;       // User's level

  const ProgressLevelCircle({required this.progress, required this.level, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40, // Circle size
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress, 
            strokeWidth: 6.0,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF735eab)), 
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
