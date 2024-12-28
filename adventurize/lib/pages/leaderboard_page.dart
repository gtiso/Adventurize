import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  final String? username;

  LeaderboardPage({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard Page'),
      ),
    );
  }
}
