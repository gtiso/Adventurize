import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/profile_card.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late User _user;

  @override
  void initState() {
    super.initState();
    // Initialize the user object
    _user = User(
      userId: 0,
      fullname: "George",
      email: "george@example.com",
      avatarPath: "lib/assets/avatars/avatar2.png",
      password: "password123",
      points: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Background
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(36.1627, -86.7816), // Example coordinates
              zoom: 12.0,
            ),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),
          // Semi-transparent overlay to dim the map
          Container(
            color: Colors.white.withOpacity(0.6), // Adjust opacity as needed
          ),
          // Main Content
          Column(
            children: [
              const SizedBox(height: 16),
              ProfileCard(user: _user),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
