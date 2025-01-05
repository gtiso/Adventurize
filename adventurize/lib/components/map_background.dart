import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/services/location_service.dart'; // Import the file

class MapBackground extends StatefulWidget {
  const MapBackground({Key? key}) : super(key: key);

  @override
  State<MapBackground> createState() => _MapBackgroundState();
}

class _MapBackgroundState extends State<MapBackground> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: LocationService.getUserCurrentLocation(), // Use the function
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
              compassEnabled: false,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                target: userLocation,
                zoom: 12.0,
              ),
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
