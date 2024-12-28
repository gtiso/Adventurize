import 'package:flutter/material.dart';

class MemoryHistoryPage extends StatelessWidget {
  final String? username;

  MemoryHistoryPage({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory History Page'),
      ),
    );
  }
}
