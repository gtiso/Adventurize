import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  final String? username;

  LeaderboardPage({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard Page'),
      ),
    );
  }
}
