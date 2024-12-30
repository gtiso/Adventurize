import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/components/small_user_card.dart';
import 'package:adventurize/components/big_user_card.dart';
import 'package:adventurize/components/title.dart';
import 'package:adventurize/models/user_model.dart';

class LeaderboardPage extends StatefulWidget {
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
    // Replace this with your data fetching logic
    setState(() {
      users = users = [
        User(
            userId: 1,
            fullname: "John Doe",
            username: "john_doe",
            email: "john.doe@example.com",
            birthdate: "1990-01-01",
            password: "password123",
            points: 1150,
            avatarPath: "lib/assets/avatars/avatar1.png"),
        User(
            userId: 2,
            fullname: "Robert Johnson",
            username: "robert_j",
            email: "robert.j@example.com",
            birthdate: "1988-03-22",
            password: "mypassword123",
            points: 550,
            avatarPath: "lib/assets/avatars/avatar2.png"),
        User(
            userId: 3,
            fullname: "Michael Lee",
            username: "michael_lee",
            email: "michael.lee@example.com",
            birthdate: "1993-06-25",
            password: "supersecure",
            points: 830,
            avatarPath: "lib/assets/avatars/avatar3.png"),
        User(
            userId: 4,
            fullname: "Jane Smith",
            username: "jane_smith",
            email: "jane.smith@example.com",
            birthdate: "1992-05-15",
            password: "securepassword",
            points: 950,
            avatarPath: "lib/assets/avatars/avatar4.png"),
        User(
            userId: 5,
            fullname: "Alice Brown",
            username: "alice_brown",
            email: "alice.b@example.com",
            birthdate: "1995-10-10",
            password: "mypassword",
            points: 775,
            avatarPath: "lib/assets/avatars/avatar5.png"),
        User(
            userId: 6,
            fullname: "Emily Davis",
            username: "emily_davis",
            email: "emily.davis@example.com",
            birthdate: "1998-02-14",
            password: "password456",
            points: 540,
            avatarPath: "lib/assets/avatars/avatar6.png"),
        User(
            userId: 7,
            fullname: "Maria Gonzalez",
            username: "maria_g",
            email: "maria.g@example.com",
            birthdate: "1998-07-23",
            password: "password789",
            points: 840,
            avatarPath: "lib/assets/avatars/avatar4.png"),
        User(
            userId: 8,
            fullname: "Konstantina Papadopoulos",
            username: "konstantina_p",
            email: "konstantina.p@example.com",
            birthdate: "1997-09-14",
            password: "strongpassword",
            points: 940,
            avatarPath: "lib/assets/avatars/avatar5.png")
      ];
    });
    _sortUsersByPoints();
  }

  void _sortUsersByPoints() {
    setState(() {
      users.sort((a, b) => b.points.compareTo(a.points));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Background
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(36.1627, -86.7816),
              zoom: 12.0,
            ),
          ),
          // Semi-transparent overlay
          Container(
            color: Colors.white.withOpacity(0.6),
          ),
          Column(
            children: [
              // Leaderboard Title
              TitleWidget(
                icon: Icons.people,
                text: "Leaderboard",
              ),
              // Fixed "You" Card
              SmallUserCard(
                user: users.first,
                onTap: () {
                  setState(() {
                    selectedUser = users.first;
                  });
                },
              ),
              // User List
              Expanded(
                child: ListView.builder(
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
                ),
              ),
            ],
          ),
          // Display BigUserCard
          if (selectedUser != null)
            Positioned.fill(
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
            ),
        ],
      ),
    );
  }
}
