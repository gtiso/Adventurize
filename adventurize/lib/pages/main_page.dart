import 'package:flutter/material.dart';
import 'package:adventurize/components/bottom_nav_component.dart';
import 'package:adventurize/pages/challenges_page.dart';
import 'package:adventurize/pages/leaderboard_page.dart';
import 'package:adventurize/pages/memory_history_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ChallengesPage(),
    LeaderboardPage(),
    MemoryHistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavComponent(
        currentIndex: _currentIndex, // Pass current index
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index; // Update index
          });
        },
      ),
    );
  }
}
