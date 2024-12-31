import 'package:flutter/material.dart';
import 'package:adventurize/models/challenge_model.dart';

class SmallChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final VoidCallback onTap;

  const SmallChallengeCard({
    required this.challenge,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  Widget _buildChallengeTitle() {
    return Positioned(
      bottom: 20,
      left: 10,
      child: Text(
        challenge.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'SansitaOne',
          shadows: [Shadow(color: Colors.black, blurRadius: 5)],
        ),
      ),
    );
  }

  Widget _buildChallengeStatus() {
    return Positioned(
      top: 10,
      right: 10,
      child: Text(
        challenge.shared == 0 ? "Not Started!" : "Completed!",
        style: TextStyle(
          color: challenge.shared == 1 ? Colors.green : Colors.red,
          fontSize: 16,
          fontFamily: 'SansitaOne',
          shadows: [Shadow(color: Colors.black, blurRadius: 5)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  challenge.photoPath ?? "assets/images/placeholder.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                _buildChallengeTitle(),
                _buildChallengeStatus(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
