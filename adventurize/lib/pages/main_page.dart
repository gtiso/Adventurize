import 'dart:async';

import 'package:adventurize/components/level_progress_circle.dart';
import 'package:adventurize/components/capture_button.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adventurize/utils/navigation_utils.dart';

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
    try {
      await Geolocator.requestPermission();
      Position userPosition = await Geolocator.getCurrentPosition();
      currentUserPosition = userPosition;
      LatLng userLatLng =
          LatLng(currentUserPosition.latitude, currentUserPosition.longitude);
      CameraPosition cameraPos = CameraPosition(target: userLatLng, zoom: 15);
      controllerGoogleMap
          .animateCamera(CameraUpdate.newCameraPosition(cameraPos));
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _loadMarkers() async {
    List<Memory> userMemories = await db.getMemoriesFromID(widget.user.userID);
    List<Memory> friendMemories = await db.getMemoriesFromFriendID(widget.user.userID);
    List<Memory> memories = userMemories + friendMemories;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) =>
            NavigationUtils.handleHorizontalDragMain(
                context, details, widget.user),
        onVerticalDragEnd: (details) => NavigationUtils.handleVerticalDragMain(
            context, details, widget.user),
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              compassEnabled: false,
            mapType: MapType.normal,
              myLocationEnabled: true,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.97934102604011, 23.78306889039801),
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
                  NavigationUtils.navigateToProfile(context, widget.user);
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
              child: CaptureButton(
                color: Colors.black,
                onPressed: () {
                  NavigationUtils.navigateToCamera(context, widget.user, null);
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
                      NavigationUtils.navigateToChallenges(
                          context, widget.user);
                    },
                    icon: Icon(Icons.diamond),
                  ),
                  IconButton(
                    iconSize: 35,
                    color: Colors.black,
                    onPressed: () {
                      NavigationUtils.navigateToLeaderboard(
                          context, widget.user);
                    },
                    icon: Icon(Icons.people),
                  ),
                  IconButton(
                    iconSize: 35,
                    color: Colors.black,
                    onPressed: () {
                      NavigationUtils.navigateToMemoryHistory(
                          context, widget.user);
                    },
                    icon: Icon(Icons.public),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
