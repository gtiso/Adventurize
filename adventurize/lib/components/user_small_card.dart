import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/level_progress_circle.dart';

class SmallUserCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const SmallUserCard({required this.user, required this.onTap, Key? key})
      : super(key: key);

  Widget _buildAvatar() {
    return CircleAvatar(
      backgroundImage: AssetImage(user.avatarPath ?? ""),
    );
  }

  Widget _buildUsername() {
    return Text(
      user.username ?? "",
      style: const TextStyle(
        fontFamily: 'SansitaOne',
      ),
    );
  }

  Widget _buildProgressCircle() {
    return ProgressLevelCircle(
      points: user.points,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: _buildAvatar(),
            title: _buildUsername(),
            trailing: _buildProgressCircle(),
          ),
        ),
      ),
    );
  }
}
