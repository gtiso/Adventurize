import 'dart:async';

import 'package:adventurize/components/level_progress_circle.dart';
import 'package:adventurize/components/shaped_button.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/pages/camera_page.dart';
import 'package:adventurize/pages/challenges_page.dart';
import 'package:adventurize/pages/leaderboard_page.dart';
import 'package:adventurize/pages/memory_history_page.dart';
import 'package:adventurize/pages/my_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({super.key, required this.user});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Completer<GoogleMapController> googleMapCompleteController =
      Completer<GoogleMapController>();
  late GoogleMapController controllerGoogleMap;
  late Position currentUserPosition;

  final db = DatabaseHelper();

  final List<Marker> _markers = [];
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR $error");
    });
    Position userPosition = await Geolocator.getCurrentPosition();
    currentUserPosition = userPosition;
    LatLng userLatLng =
        LatLng(currentUserPosition.latitude, currentUserPosition.longitude);
    CameraPosition cameraPos = CameraPosition(target: userLatLng, zoom: 15);
    controllerGoogleMap
        .animateCamera(CameraUpdate.newCameraPosition(cameraPos));
  }

  Future<void> _loadMarkers() async {
    List<Memory> memories = await db.getMemories();

    for (final memory in memories) {
      BitmapDescriptor icon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(40, 40)),
        memory.userAvatarPath,
      );

      _markers.add(
        Marker(
          markerId: MarkerId(memory.memoryID.toString()),
          position: LatLng(memory.latitude, memory.longitude),
          icon: icon,
          infoWindow: InfoWindow(
            title: memory.title,
            snippet: memory.userName,
          ),
        ),
      );
    }

    setState(() {
      debugPrint("${_markers.length} markers loaded.");
    });
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyProfilePage(user: widget.user)),
    );
  }

  void _navigateToChallenges() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChallengesPage(
                user: widget.user,
              )),
    );
  }

  void _navigateToLeaderboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LeaderboardPage(
                user: widget.user,
              )),
    );
  }

  void _navigateToMemories() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MemoryHistoryPage(
                user: widget.user,
              )),
    );
  }

  void _navigateToCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPage(user: widget.user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.97934102604011, 23.78306889039801), // EMP
              zoom: 12,
            ),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;
              googleMapCompleteController.complete(controllerGoogleMap);
              _getUserCurrentLocation();
            },
          ),
          Align(
            alignment: Alignment(0.95, -0.95),
            child: IconButton.filled(
              iconSize: 25,
              onPressed: () {
                _navigateToProfile();
              },
              icon: Icon(Icons.person),
            ),
          ),
          Align(
            alignment: Alignment(-0.95, -0.95),
            child: ProgressLevelCircle(
              points: widget.user.points,
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.6),
            child: ShapedButton(
              onPressed: () {
                _navigateToCamera();
              },
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  iconSize: 35,
                  color: Colors.black,
                  onPressed: () {
                    _navigateToChallenges();
                  },
                  icon: Icon(Icons.diamond),
                ),
                IconButton(
                  iconSize: 35,
                  color: Colors.black,
                  onPressed: () {
                    _navigateToLeaderboard();
                  },
                  icon: Icon(Icons.people),
                ),
                IconButton(
                  iconSize: 35,
                  color: Colors.black,
                  onPressed: () {
                    _navigateToMemories();
                  },
                  icon: Icon(Icons.public),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
