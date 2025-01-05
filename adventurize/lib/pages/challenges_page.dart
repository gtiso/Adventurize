import 'package:adventurize/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:adventurize/components/cards/challenge_small_card.dart';
import 'package:adventurize/components/map_background.dart';
import 'package:adventurize/components/title.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/components/cards/challenge_big_card.dart';
import 'package:adventurize/utils/navigation_utils.dart';

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
  Map<int, int> challengeStatuses = {};

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  Future<void> _initializeData() async {
    await _fetchChallenges();
  }

  Future<void> _fetchChallenges() async {
    List<Challenge> data = await db.getChalls();
    await db.insUserChallenges(widget.user.userID, data.length);
    setState(() {
      challenges = data;
    });
    for (var challenge in data) {
      debugPrint("Challenges Page: challengeID = ${challenge.challengeID}");
      await statusSetter(challenge.challengeID ?? 0);
    }
  }

  Future<void> statusSetter(int challID) async {
    int res = await db.getChallStatus(widget.user.userID, challID);
    setState(() {
      challengeStatuses[challID] = res; // Update the status for the specific challenge
    });
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
        final challStatus = challengeStatuses[challenge.challengeID] ?? 0;
        return SmallChallengeCard(
          challenge: challenge,
          onTap: () async {
            await statusSetter(challenge.challengeID ?? 0);
            setState(() {
              selectedChallenge = challenge; // Set the selected challenge
            });
          },
          challStatus: challStatus,
        );
      },
    );
  }

  Widget _buildBigCard() {
    if (selectedChallenge == null) return const SizedBox.shrink();
    final challStatus = challengeStatuses[selectedChallenge!.challengeID] ?? 0;

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
              },
              user: widget.user,
              challStatus: challStatus,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          NavigationUtils.handleHorizontalDragChallenges(
              context, details, widget.user);
        },
        child: Stack(
          children: [
            const MapBackground(),
            Column(
              children: [
                _buildTitle(),
                Expanded(child: _buildChallengesList()),
              ],
            ),
            _buildBigCard(),
          ],
        ),
      ),
    );
  }
}
