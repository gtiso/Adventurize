import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';

class ProfileCard extends StatelessWidget {
  final User user;

  const ProfileCard({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _navigateToEdit() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const PlaceholderPage(title: 'Edit Profile')),
      );
    }

    void _navigateToSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const PlaceholderPage(title: 'Settings')),
      );
    }

    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              // Settings Button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: _navigateToSettings,
                  icon: const Icon(Icons.settings),
                  color: Colors.black,
                ),
              ),
              // Edit Button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: _navigateToEdit,
                  icon: const Icon(Icons.edit),
                  color: Colors.black,
                ),
              ),
              // Main Profile Content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(user.avatarPath ?? ""),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      user.fullname ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SansitaOne',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Implement QR scanning logic here
                      },
                      icon: const Icon(Icons.camera_alt, color: Colors.black),
                      label: const Text(
                        'Scan QR',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SansitaOne',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text("This is the $title page."),
      ),
    );
  }
}
