import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/components/big_memory_card.dart';
import 'package:adventurize/components/small_memory_card.dart';
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
      latitude: 48.8584,
      longitude: 2.2945,
    ),
    Memory(
      title: "Louvre Museum, Paris",
      description: "Explored the world-famous art museum.",
      imagePath: "lib/assets/challenges/view.jpg",
      date: "July 13, 2023",
      latitude: 48.8606,
      longitude: 2.3376,
    ),
    Memory(
      title: "Arc De Triomphe, Paris",
      description: "Experienced the historic Arc de Triomphe.",
      imagePath: "lib/assets/challenges/step.jpg",
      date: "July 14, 2023",
      latitude: 48.8738,
      longitude: 2.2950,
    ),
  ];

  Memory? selectedMemory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
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
          ),
          // Title
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: TitleWidget(
              icon: Icons.language,
              text: "Memories",
            ),
          ),
          // SmallMemoryCards List at Bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
            ),
          ),
          // BigMemoryCard Pop-up
          if (selectedMemory != null)
            GestureDetector(
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
            ),
        ],
      ),
    );
  }
}
