import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/level_progress_circle.dart';

class SmallUserCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const SmallUserCard({required this.user, required this.onTap, Key? key})
      : super(key: key);

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
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(user.avatarPath ?? ""),
            ),
            title: Text(user.username ?? "",
                style: TextStyle(fontFamily: 'SansitaOne')),
            trailing: ProgressLevelCircle(
              points: user.points,
            ),
          ),
        ),
      ),
    );
  }
}
