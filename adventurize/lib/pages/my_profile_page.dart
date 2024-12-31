import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/cards/profile_card.dart';

class MyProfilePage extends StatefulWidget {
  final User user;
  const MyProfilePage({super.key, required this.user});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildMapBackground() {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: const CameraPosition(
        target: LatLng(36.1627, -86.7816), // Example coordinates
        zoom: 12.0,
      ),
      myLocationButtonEnabled: false,
    );
  }

  Widget _buildOverlay() {
    return Container(
      color: Colors.white.withOpacity(0.6), // Adjust opacity as needed
    );
  }

  Widget _buildProfileContent() {
    return Column(
      children: [
        const SizedBox(height: 16),
        ProfileCard(user: widget.user),
        const Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMapBackground(),
          _buildOverlay(),
          _buildProfileContent(),
        ],
      ),
    );
  }
}
