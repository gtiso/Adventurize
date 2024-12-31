import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/qr_code_display.dart';
import 'package:adventurize/pages/edit_profile_page.dart';
import 'package:adventurize/pages/settings_page.dart';

class ProfileCard extends StatelessWidget {
  final User user;

  const ProfileCard({
    required this.user,
    Key? key,
  }) : super(key: key);

  void _navigateToEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => _navigateToSettings(context),
          icon: const Icon(Icons.settings),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () => _navigateToEdit(context),
          icon: const Icon(Icons.edit),
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage(user.avatarPath ?? ""),
    );
  }

  Widget _buildFullName() {
    return Text(
      user.fullname ?? "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'SansitaOne',
      ),
    );
  }

  Widget _buildQRCode() {
    return QRCodeDisplay(
      data: user.email,
      size: 150.0,
    );
  }

  Widget _buildScanQRButton() {
    return ElevatedButton.icon(
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
    );
  }

  @override
  Widget build(BuildContext context) {
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTopRow(context),
              const SizedBox(height: 8),
              _buildAvatar(),
              const SizedBox(height: 8),
              _buildFullName(),
              const SizedBox(height: 16),
              _buildQRCode(),
              const SizedBox(height: 16),
              _buildScanQRButton(),
            ],
          ),
        ),
      ),
    );
  }
}
