import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/components/cards/memory_small_card.dart';
import 'package:adventurize/components/title.dart';
import 'package:adventurize/utils/navigation_utils.dart';
import 'dart:async';

class MemoryHistoryPage extends StatefulWidget {
  final User user;
  const MemoryHistoryPage({super.key, required this.user});

  @override
  State<MemoryHistoryPage> createState() => _MemoryHistoryPageState();
}

class _MemoryHistoryPageState extends State<MemoryHistoryPage> {
  List<Memory> memories = [];

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
      memories = data.reversed.toList();
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
                  onTap: () {
                    NavigationUtils.navigateToSelectedMemory(
                        context, widget.user, memory);
                  },
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
              NavigationUtils.navigateToSelectedMemory(
                  context, widget.user, memory);
            },
          );
        },
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
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
          _buildBackButton(context),
        ],
      ),
    );
  }
}
