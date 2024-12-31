import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/components/cards/memory_big_card.dart';
import 'package:adventurize/components/cards/memory_small_card.dart';
import 'package:adventurize/components/title.dart';

class MemoryHistoryPage extends StatefulWidget {
  @override
  State<MemoryHistoryPage> createState() => _MemoryHistoryPageState();
}

class _MemoryHistoryPageState extends State<MemoryHistoryPage> {
  final List<Memory> memories = [
    Memory(
      title: "Tour Eiffel, Paris",
      description: "Visited the iconic Eiffel Tower and enjoyed the view.",
      imagePath: "lib/assets/challenges/food.jpg",
      date: "July 12, 2023",
      latitude: 36.1627,
      longitude: -86.7816,
    ),
    Memory(
      title: "Louvre Museum, Paris",
      description: "Explored the world-famous art museum.",
      imagePath: "lib/assets/challenges/view.jpg",
      date: "July 13, 2023",
      latitude: 36.1627,
      longitude: -86.7500,
    ),
    Memory(
      title: "Arc De Triomphe, Paris",
      description: "Experienced the historic Arc de Triomphe.",
      imagePath: "lib/assets/challenges/step.jpg",
      date: "July 14, 2023",
      latitude: 36.1400,
      longitude: -86.7816,
    ),
  ];

  Memory? selectedMemory;

  Widget _buildGoogleMap() {
    return GoogleMap(
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(memories.first.latitude, memories.first.longitude),
        zoom: 12,
      ),
      markers: memories
          .map((memory) => Marker(
                markerId: MarkerId(memory.title),
                position: LatLng(memory.latitude, memory.longitude),
                infoWindow: InfoWindow(title: memory.title),
              ))
          .toSet(),
    );
  }

  Widget _buildTitle() {
    return const TitleWidget(
      icon: Icons.public,
      text: "Memories",
    );
  }

  Widget _buildMemoryList() {
    return Expanded(
      child: ListView.builder(
        itemCount: memories.length,
        itemBuilder: (context, index) {
          final memory = memories[index];
          return SmallMemoryCard(
            memory: memory,
            onTap: () {
              setState(() {
                selectedMemory = memory;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildBigMemoryCard() {
    if (selectedMemory == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMemory = null;
        });
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: BigMemoryCard(
            memory: selectedMemory!,
            onClose: () {
              setState(() {
                selectedMemory = null;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(),
          Column(
            children: [
              _buildTitle(),
              const SizedBox(height: 240),
              _buildMemoryList(),
            ],
          ),
          _buildBigMemoryCard(),
        ],
      ),
    );
  }
}
