import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/qr_code_display.dart';

class BigUserCard extends StatelessWidget {
  final User user;
  final VoidCallback onClose;

  const BigUserCard({required this.user, required this.onClose, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(user.avatarPath ?? ""),
          ),
          SizedBox(height: 12),
          Text(
            user.fullname ?? "",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'SansitaOne',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          // QR Code
          QRCodeDisplay(
            data: user.email,
            size: 150.0,
          ),
          const SizedBox(height: 16),
          Text(
            "Score: ${user.points}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
