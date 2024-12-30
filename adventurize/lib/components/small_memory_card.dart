import 'package:flutter/material.dart';
import 'package:adventurize/models/memory_model.dart';

class SmallMemoryCard extends StatelessWidget {
  final Memory memory;
  final VoidCallback onTap;

  const SmallMemoryCard({
    Key? key,
    required this.memory,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.location_on,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  memory.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
