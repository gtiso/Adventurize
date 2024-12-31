import 'package:adventurize/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/components/cards/challenge_small_card.dart';
import 'package:adventurize/components/title.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/components/cards/challenge_big_card.dart';

class ChallengesPage extends StatefulWidget {
  final User user;
  const ChallengesPage({super.key, required this.user});
  
  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  List<Challenge> challenges = [];
  Challenge? selectedChallenge; // To hold the selected challenge for BigCard
  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchChallenges();
  }

  Future<void> _fetchChallenges() async {
    List<Challenge> data = await db.getChalls();
    setState(() {
      challenges = data;
    });
  }

  Widget _buildMapBackground() {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(36.1627, -86.7816), // Example coordinates
        zoom: 12.0,
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      color: Colors.white.withOpacity(0.6), // Adjust opacity as needed
    );
  }

  Widget _buildTitle() {
    return const TitleWidget(
      icon: Icons.diamond,
      text: "Challenges",
    );
  }

  Widget _buildChallengesList() {
    if (challenges.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return SmallChallengeCard(
          challenge: challenge,
          onTap: () {
            setState(() {
              selectedChallenge = challenge; // Set the selected challenge
            });
          },
        );
      },
    );
  }

  Widget _buildBigCard() {
    if (selectedChallenge == null) return const SizedBox.shrink();

    return Positioned.fill(
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
              }, user: widget.user,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMapBackground(),
          _buildOverlay(),
          Column(
            children: [
              _buildTitle(),
              Expanded(child: _buildChallengesList()),
            ],
          ),
          _buildBigCard(),
        ],
      ),
    );
  }
}
