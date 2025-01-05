import 'dart:io';
import 'package:flutter/material.dart';

class MemoryImageWidget extends StatelessWidget {
  final String imagePath;
  final String avatarPath;
  final double width;
  final double height;

  const MemoryImageWidget({
    required this.imagePath,
    required this.avatarPath,
    this.width = 200,
    this.height = 300,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Image path: $imagePath");
    debugPrint("Avatar path: $avatarPath");

    Widget imageWidget;
    try {
      if (File(imagePath).existsSync()) {
        // File-based image handling
        imageWidget = Image.file(
          File(imagePath),
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      } else {
        // If file doesn't exist, assume it's an asset image
        imageWidget = Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      debugPrint("Error loading image: $e");
      // Fallback for any error
      imageWidget = Container(
        width: width,
        height: height,
        color: Colors.grey.shade300,
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

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background image (file or asset)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageWidget,
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
  }
}
