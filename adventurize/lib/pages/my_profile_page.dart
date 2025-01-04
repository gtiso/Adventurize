import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/components/cards/profile_card.dart';
import 'package:adventurize/components/map_background.dart';
import 'package:adventurize/utils/navigation_utils.dart';

class MyProfilePage extends StatefulWidget {
  final User user;
  const MyProfilePage({super.key, required this.user});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildProfileContent() {
    return Align(
      alignment: Alignment.center,
      child: ProfileCard(user: widget.user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragEnd: (DragEndDetails details) {
          NavigationUtils.handleVerticalDragProfile(
              context, details, widget.user);
        },
        child: Stack(
          children: [
            const MapBackground(),
            _buildProfileContent(),
          ],
        ),
      ),
    );
  }
}
