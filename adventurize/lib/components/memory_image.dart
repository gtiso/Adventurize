import 'dart:io';
import 'package:flutter/material.dart';

class MemoryImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final String avatarPath;

  const MemoryImageWidget({
    required this.imagePath,
    required this.avatarPath,
    this.width = 200,
    this.height = 300,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Image file path: $imagePath");
    debugPrint("Avatar path: $avatarPath");

    if (File(imagePath).existsSync()) {
      return SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(imagePath),
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            // Top Center Avatar
            Positioned(
              top: 16,
              child: CircleAvatar(
                backgroundImage: AssetImage(avatarPath),
                radius: 20,
                backgroundColor: Colors.white,
              ),
            ),
          ],
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
