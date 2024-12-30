import 'package:flutter/material.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/pages/memory_history_page.dart';
import 'package:adventurize/pages/camera_page.dart';

class BigChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final VoidCallback onClose;

  const BigChallengeCard(
      {required this.challenge, required this.onClose, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              challenge.photoPath ?? "assets/images/placeholder.png",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SansitaOne',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  challenge.desc,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Upload your picture to the app and earn ${challenge.points ?? 0} XP.",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (challenge.shared == 0) {
                        // Navigate to the CameraPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraPage(),
                          ),
                        );
                      } else {
                        // Navigate to the "View Memory" page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemoryHistoryPage(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      challenge.shared == 0 ? "START CHALLENGE" : "VIEW MEMORY",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'SansitaOne',
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
