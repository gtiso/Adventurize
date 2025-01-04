import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/components/cards/memory_big_card.dart';
import 'package:adventurize/components/cards/memory_small_card.dart';
import 'package:adventurize/components/title.dart';
import 'package:adventurize/utils/navigation_utils.dart';

class MemoryHistoryPage extends StatefulWidget {
  final User user;
  const MemoryHistoryPage({super.key, required this.user});

  @override
  State<MemoryHistoryPage> createState() => _MemoryHistoryPageState();
}

class _MemoryHistoryPageState extends State<MemoryHistoryPage> {
  List<Memory> memories = [];
  Memory? selectedMemory;

  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchMemories();
  }

  Future<void> _fetchMemories() async {
    List<Memory> data = await db.getMemoriesFromID(widget.user.userID);
    setState(() {
      memories = data;
    });
  }

  Widget _buildGoogleMap() {
    if (memories.isNotEmpty) {
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
    } else {
      return GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        mapToolbarEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target:
              LatLng(37.97934102604011, 23.78306889039801), // Default location
          zoom: 12,
        ),
      );
    }
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

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment:
          Alignment.centerLeft, // Aligns to the vertical center, left edge
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10), // Adds space from the left edge
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
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
              const SizedBox(height: 320),
              _buildMemoryList(),
            ],
          ),
          _buildBigMemoryCard(),
          _buildBackButton(context),
        ],
      ),
    );
  }
}
