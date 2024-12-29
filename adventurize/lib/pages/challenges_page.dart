import 'package:flutter/material.dart';
import 'package:adventurize/components/small_card.dart';
import 'package:adventurize/components/title.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/challenge_model.dart';

class ChallengesPage extends StatefulWidget {
  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  List<Challenge> challenges = []; // To hold the fetched challenges

  @override
  void initState() {
    super.initState();
    _addDummyData(); // Add dummy data on app start
    _fetchChallenges(); // Fetch challenges from the database
  }

  final db = DatabaseHelper();

  // Add dummy data to the database
  Future<void> _addDummyData() async {
    await db.insDemoData();
  }

  // Fetch all challenges from the database
  Future<void> _fetchChallenges() async {
    List<Challenge> data = await db.getChalls();
    print(data);
    setState(() {
      challenges = data; // Update the state with the fetched challenges
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background map (use a placeholder for now)
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(
          //           "assets/images/map_background.png"), // Replace with your map image
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          // Title and list of challenges
          Column(
            children: [
              TitleWidget(
                icon: Icons.diamond,
                text: "Challenges",
              ),
              // Scrollable list of SmallCard widgets
              Expanded(
                child: challenges.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: challenges.length,
                        itemBuilder: (context, index) {
                          final challenge = challenges[index];
                          return SmallCard(
                            title: challenge.title,
                            photoPath: challenge.photoPath ?? '',
                            status:
                                "CHALLENGE STATUS", // Replace with actual status if needed
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
