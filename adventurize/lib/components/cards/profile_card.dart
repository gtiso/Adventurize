import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/qr_code_display.dart';
import 'package:adventurize/navigation_utils.dart';

class ProfileCard extends StatelessWidget {
  final User user;

  const ProfileCard({
    required this.user,
    super.key,
  });

  Widget _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => NavigationUtils.navigateToSettings(context),
          icon: const Icon(Icons.settings),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () => NavigationUtils.navigateToEdit(context, user),
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

  Widget _buildScore() {
    return Text(
      "Score: ${user.points}",
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
    );
  }

  Widget _buildScanQRButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => NavigationUtils.navigateToQRScanner(context),
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
              _buildScore(),
              const SizedBox(height: 8),
              _buildScanQRButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
