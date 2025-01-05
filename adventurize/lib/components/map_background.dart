import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/services/location_service.dart';

class MapBackground extends StatefulWidget {
  final LatLng? specificCoordinates;

  const MapBackground({Key? key, this.specificCoordinates}) : super(key: key);

  @override
  State<MapBackground> createState() => _MapBackgroundState();
}

class _MapBackgroundState extends State<MapBackground> {
  late Future<LatLng> _locationFuture;

  @override
  void initState() {
    super.initState();
    // Use specific coordinates if provided, otherwise fetch the user's location
    _locationFuture = widget.specificCoordinates != null
        ? Future.value(widget.specificCoordinates)
        : LocationService.getUserCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: _locationFuture,
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

        final targetLocation = snapshot.data!;
        return Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              compassEnabled: false,
              mapType: MapType.normal,
              myLocationEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: targetLocation,
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
