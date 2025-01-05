import 'package:flutter/material.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/components/memory_image.dart';

class BigMemoryCard extends StatelessWidget {
  final Memory memory;
  final VoidCallback onClose;

  const BigMemoryCard({required this.memory, required this.onClose, Key? key})
      : super(key: key);

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          elevation: 4, // Adds shadow for depth
          borderRadius: BorderRadius.circular(10),
          child: MemoryImageWidget(
            imagePath: memory.imagePath,
            width: double.infinity,
            height: 300,
            avatarPath: memory.userAvatarPath,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      memory.title,
      style: const TextStyle(
        fontSize: 20,
        fontFamily: 'SansitaOne',
        color: Colors.white,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      memory.description,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDateCaptured() {
    return Text(
      "Memory captured on ${memory.date}",
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }

  Widget _buildUsername() {
    return Text(
      memory.userName,
      style: const TextStyle(
        fontSize: 15,
        fontFamily: 'SansitaOne',
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUsername(),
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildDescription(),
                  const SizedBox(height: 16),
                  _buildDateCaptured(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
