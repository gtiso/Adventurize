import 'package:flutter/material.dart';

class ChallengesPage extends StatelessWidget {
  final String? username;

  ChallengesPage({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges Page'),
      ),
    );
  }
}
