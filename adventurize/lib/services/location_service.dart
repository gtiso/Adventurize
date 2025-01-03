import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  /// Fetches the user's current location.
  static Future<LatLng> getUserCurrentLocation() async {
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
}
