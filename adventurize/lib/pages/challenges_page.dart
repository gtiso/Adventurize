import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/components/small_challenge_card.dart';
import 'package:adventurize/components/title.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/components/big_challenge_card.dart';

class ChallengesPage extends StatefulWidget {
  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  List<Challenge> challenges = [];
  Challenge? selectedChallenge; // To hold the selected challenge for BigCard

  @override
  void initState() {
    super.initState();
    _addDummyData();
    _fetchChallenges();
  }

  final db = DatabaseHelper();

  Future<void> _addDummyData() async {
    await db.insDemoData();
  }

  Future<void> _fetchChallenges() async {
    List<Challenge> data = await db.getChalls();
    setState(() {
      challenges = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Background
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(36.1627, -86.7816), // Example coordinates
              zoom: 12.0,
            ),
          ),
          // Semi-transparent overlay to dim the map
          Container(
            color: Colors.white.withOpacity(0.6), // Adjust opacity as needed
          ),
          // Main Content
          Column(
            children: [
              TitleWidget(
                icon: Icons.diamond,
                text: "Challenges",
              ),
              Expanded(
                child: challenges.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: challenges.length,
                        itemBuilder: (context, index) {
                          final challenge = challenges[index];
                          return SmallChallengeCard(
                            challenge: challenge,
                            onTap: () {
                              setState(() {
                                selectedChallenge =
                                    challenge; // Set the selected challenge
                              });
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
          // Display BigCard if a challenge is selected
          if (selectedChallenge != null)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedChallenge = null; // Close the BigCard
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: BigChallengeCard(
                      challenge: selectedChallenge!,
                      onClose: () {
                        setState(() {
                          selectedChallenge = null; // Close the BigCard
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
