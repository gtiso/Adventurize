import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/profile_card.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with actual user retrieval logic
    final Users user = Users(
      fullname: "George",
      email: "george@example.com",
      password: "password123",
      points: 100,
    );

    return Scaffold(
      body: Stack(
        children: [
          // Background Map (Google Maps Mockup)
          const Positioned.fill(
            child: Image(
              image: AssetImage('assets/map_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          // Profile Card
          Align(
            alignment: Alignment.center,
            child: ProfileCard(user: user),
          ),
          // Top Bar with Icons
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Navigate to settings page
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to edit profile page
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
