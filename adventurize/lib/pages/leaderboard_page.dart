import 'package:adventurize/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/components/cards/user_small_card.dart';
import 'package:adventurize/components/cards/user_big_card.dart';
import 'package:adventurize/components/title.dart';
import 'package:adventurize/models/user_model.dart';

class LeaderboardPage extends StatefulWidget {
  final User user;
  const LeaderboardPage({super.key, required this.user});
  
  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<User> users = [];
  User? selectedUser;
  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _fetchLeaderboardData();
  }

  Future<void> _fetchLeaderboardData() async {
    List<User> data = await db.getUsers();
    setState(() {
      users = data;
      _sortUsersByPoints();
    });
  }

  void _sortUsersByPoints() {
    users.sort((a, b) => b.points.compareTo(a.points));
  }

  Widget _buildMapBackground() {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(36.1627, -86.7816),
        zoom: 12.0,
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      color: Colors.white.withOpacity(0.6),
    );
  }

  Widget _buildTitle() {
    return const TitleWidget(
      icon: Icons.people,
      text: "Leaderboard",
    );
  }

  Widget _buildFixedUserCard() {
    if (users.isEmpty) return const SizedBox.shrink();

    return SmallUserCard(
      user: users.first,
      onTap: () {
        setState(() {
          selectedUser = users.first;
        });
      },
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return SmallUserCard(
          user: user,
          onTap: () {
            setState(() {
              selectedUser = user;
            });
          },
        );
      },
    );
  }

  Widget _buildBigUserCard() {
    if (selectedUser == null) return const SizedBox.shrink();

    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedUser = null;
          });
        },
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: BigUserCard(
              user: selectedUser!,
              onClose: () {
                setState(() {
                  selectedUser = null;
                });
              },
            ),
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
          _buildMapBackground(),
          _buildOverlay(),
          Column(
            children: [
              _buildTitle(),
              _buildFixedUserCard(),
              Expanded(child: _buildUserList()),
            ],
          ),
          _buildBigUserCard(),
        ],
      ),
    );
  }
}
