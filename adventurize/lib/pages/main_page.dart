import 'package:adventurize/components/level_progress_circle.dart';
import 'package:adventurize/components/shaped_button.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/pages/camera_page.dart';
import 'package:adventurize/pages/challenges_page.dart';
import 'package:adventurize/pages/leaderboard_page.dart';
import 'package:adventurize/pages/memory_history_page.dart';
import 'package:adventurize/pages/my_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({super.key, required this.user});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late GoogleMapController _mapController;

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyProfilePage(user: widget.user,)),
    );
  }

  void _navigateToChallenges() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChallengesPage(user: widget.user,)),
    );
  }

  void _navigateToLeaderboard() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeaderboardPage(user: widget.user,)),
    );
  }

  void _navigateToMemories() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MemoryHistoryPage(user: widget.user,)),
    );
  }

  void _navigateToCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPage()),
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
            initialCameraPosition: CameraPosition(
              target: LatLng(36.1627, -86.7816),
              zoom: 12,
            ),
            onMapCreated: (controller) => _mapController = controller,
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