import 'package:flutter/material.dart';
import 'package:adventurize/pages/challenges_page.dart';
import 'package:adventurize/pages/leaderboard_page.dart';
import 'package:adventurize/pages/memory_history_page.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconButton(
            context,
            icon: Icons.diamond,
            targetPage: ChallengesPage(),
            offset: Offset(-1.0, 0.0), // Swipe left
          ),
          _buildIconButton(
            context,
            icon: Icons.people,
            targetPage: LeaderboardPage(),
            offset: Offset(0.0, 1.0), // Swipe up
          ),
          _buildIconButton(
            context,
            icon: Icons.language,
            targetPage: MemoryHistoryPage(),
            offset: Offset(1.0, 0.0), // Swipe right
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    required Widget targetPage,
    required Offset offset,
  }) {
    return IconButton(
      icon: Icon(icon, size: 30),
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => targetPage,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: offset, end: end)
                  .chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
