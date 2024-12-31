import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/qr_code_display.dart';

class BigUserCard extends StatelessWidget {
  final User user;
  final VoidCallback onClose;

  const BigUserCard({required this.user, required this.onClose, Key? key})
      : super(key: key);

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
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: 'SansitaOne',
        color: Colors.black,
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(),
          const SizedBox(height: 12),
          _buildFullName(),
          const SizedBox(height: 16),
          _buildQRCode(),
          const SizedBox(height: 16),
          _buildScore(),
        ],
      ),
    );
  }
}
