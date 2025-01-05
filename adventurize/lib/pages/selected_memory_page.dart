import 'package:flutter/material.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/cards/memory_big_card.dart';
import 'package:adventurize/components/map_background.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectedMemoryPage extends StatelessWidget {
  final User user;
  final Memory memory;

  const SelectedMemoryPage({required this.user, required this.memory, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Use MapBackground as the background
          MapBackground(
              specificCoordinates: LatLng(memory.latitude, memory.longitude)),
          // Center the BigMemoryCard
          Center(
            child: BigMemoryCard(
              memory: memory,
              onClose: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
