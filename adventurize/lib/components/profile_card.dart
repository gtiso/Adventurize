import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/qr_code_display.dart';

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
          decoration: BoxDecoration(
            color: Colors.white, // Set background color to white
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Row with Settings and Edit Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _navigateToSettings,
                    icon: const Icon(Icons.settings),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: _navigateToEdit,
                    icon: const Icon(Icons.edit),
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Profile Avatar
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(user.avatarPath ?? ""),
              ),
              const SizedBox(height: 8),
              // Full Name
              Text(
                user.fullname ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SansitaOne',
                ),
              ),
              const SizedBox(height: 16),
              // QR Code
              QRCodeDisplay(
                data: user.email ?? 'No email available',
                size: 150.0,
              ),
              const SizedBox(height: 16),
              // Scan QR Button
              ElevatedButton.icon(
                onPressed: () {
                  // Placeholder for Scan QR functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                label: const Text(
                  'SCAN QR',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SansitaOne',
                  ),
                ),
              ),
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
