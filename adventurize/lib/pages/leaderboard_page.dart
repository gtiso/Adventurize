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

  @override
  void initState() {
    super.initState();
    _fetchLeaderboardData();
  }

  Future<void> _fetchLeaderboardData() async {
    setState(() {
      users = [
        User(
          userId: 1,
          fullname: 'John Doe',
          username: 'john_doe',
          email: 'john.doe@example.com',
          birthdate: '1990-01-01',
          password: 'password123',
          points: 1150,
          avatarPath: 'lib/assets/avatars/avatar1.png',
        ),
        User(
          userId: 2,
          fullname: 'Robert Johnson',
          username: 'robert_j',
          email: 'robert.j@example.com',
          birthdate: '1988-03-22',
          password: 'mypassword123',
          points: 550,
          avatarPath: 'lib/assets/avatars/avatar2.png',
        ),
        User(
          userId: 3,
          fullname: 'Michael Lee',
          username: 'michael_lee',
          email: 'michael.lee@example.com',
          birthdate: '1993-06-25',
          password: 'supersecure',
          points: 830,
          avatarPath: 'lib/assets/avatars/avatar3.png',
        ),
        User(
          userId: 4,
          fullname: 'Jane Smith',
          username: 'jane_smith',
          email: 'jane.smith@example.com',
          birthdate: '1992-05-15',
          password: 'securepassword',
          points: 950,
          avatarPath: 'lib/assets/avatars/avatar4.png',
        ),
        User(
          userId: 5,
          fullname: 'Alice Brown',
          username: 'alice_brown',
          email: 'alice.b@example.com',
          birthdate: '1995-10-10',
          password: 'mypassword',
          points: 775,
          avatarPath: 'lib/assets/avatars/avatar5.png',
        ),
        User(
          userId: 6,
          fullname: 'Emily Davis',
          username: 'emily_davis',
          email: 'emily.davis@example.com',
          birthdate: '1998-02-14',
          password: 'password456',
          points: 540,
          avatarPath: 'lib/assets/avatars/avatar6.png',
        ),
        User(
          userId: 7,
          fullname: 'Maria Gonzalez',
          username: 'maria_g',
          email: 'maria.g@example.com',
          birthdate: '1998-07-23',
          password: 'password789',
          points: 840,
          avatarPath: 'lib/assets/avatars/avatar4.png',
        ),
        User(
          userId: 8,
          fullname: 'Konstantina Papadopoulos',
          username: 'konstantina_p',
          email: 'konstantina.p@example.com',
          birthdate: '1997-09-14',
          password: 'strongpassword',
          points: 940,
          avatarPath: 'lib/assets/avatars/avatar5.png',
        ),
      ];
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
