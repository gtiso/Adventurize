import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapBackground extends StatefulWidget {
  const MapBackground({Key? key}) : super(key: key);

  @override
  State<MapBackground> createState() => _MapBackgroundState();
}

class _MapBackgroundState extends State<MapBackground> {
  Future<LatLng> _getUserCurrentLocation() async {
    try {
      // Request permissions
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      } else if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permissions are permanently denied.");
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Failed to get location: $e");
      // Handle the error case by throwing or providing a default location
      throw Exception("Unable to fetch user location.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: _getUserCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Text("Failed to get location."),
          );
        }

        final userLocation = snapshot.data!;
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: userLocation,
                zoom: 12.0,
              ),
              myLocationEnabled: true,
            ),
            Container(
              color: Colors.white.withOpacity(0.6),
            ),
          ],
        );
      },
    );
  }
}
