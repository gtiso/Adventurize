import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';

class ProfileCard extends StatelessWidget {
  final User user;

  const ProfileCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile Avatar
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            child: Text(
              user.fullname?.substring(0, 1).toUpperCase() ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // User Name
          Text(
            user.fullname ?? 'No Name',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // QR Code
          // QrImage(
          //   data: user.email,
          //   size: 120,
          //   backgroundColor: Colors.white,
          // ),
          // const SizedBox(height: 16),
          // Scan QR Button
          ElevatedButton.icon(
            onPressed: () {
              // Add QR scan functionality here
            },
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('SCAN QR'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
