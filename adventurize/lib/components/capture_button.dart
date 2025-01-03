import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;

  const CaptureButton({
    required this.onPressed,
    this.color = Colors.white, // Default color
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 90.0,
        height: 90.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 6.5,
          ),
        ),
      ),
    );
  }
}
