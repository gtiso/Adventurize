import 'dart:io';
import 'package:flutter/material.dart';

class MemoryImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const MemoryImageWidget({
    required this.imagePath,
    this.width = 200,
    this.height = 300,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Image file path: $imagePath");

    if (File(imagePath).existsSync()) {
      return SizedBox(
        width: width,
        height: height,
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover, // Ensures the image covers the box
        ),
      );
    } else {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300, // Subtle background color
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade500, // Border color for visual appeal
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.image_not_supported,
                  color: Colors.grey.shade700, size: 48),
              const SizedBox(height: 8),
              Text(
                'Image not found',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
