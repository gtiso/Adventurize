import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/pages/camera_page.dart';
import 'package:adventurize/pages/challenges_page.dart';
import 'package:adventurize/pages/leaderboard_page.dart';
import 'package:adventurize/pages/memory_history_page.dart';
import 'package:adventurize/pages/my_profile_page.dart';
import 'package:adventurize/pages/post_memory_page.dart';
import 'package:adventurize/pages/register_page.dart';
import 'package:adventurize/pages/main_page.dart';
import 'package:adventurize/pages/login_page.dart';
import 'package:adventurize/pages/edit_profile_page.dart';
import 'package:adventurize/pages/settings_page.dart';
import 'package:adventurize/pages/QR_code_scanner_page.dart';
import 'dart:io';

class NavigationUtils {
  static void navigateToProfile(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyProfilePage(user: user)),
    );
  }

  static void navigateToChallenges(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChallengesPage(user: user)),
    );
  }

  static void navigateToLeaderboard(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeaderboardPage(user: user)),
    );
  }

  static void navigateToMemories(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MemoryHistoryPage(user: user)),
    );
  }

  static void navigateToCamera(
      BuildContext context, User user, Challenge? challenge) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPage(user: user, challenge: challenge),
      ),
    );
  }

  static void navigateToPostMemory(
      BuildContext context, File image, User user, Challenge? challenge) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostMemoryPage(
          image: image,
          user: user,
          challenge: challenge,
        ),
      ),
    );
  }

  static void navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  static void navigateToMainPage(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage(user: user)),
    );
  }

  static void navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  static void navigateToMemoryHistory(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoryHistoryPage(user: user),
      ),
    );
  }

  static void navigateToEdit(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(user: user),
      ),
    );
  }

  static void navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

  static void navigateToQRScanner(BuildContext context, User usr) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRCodeScannerPage(user: usr)),
    );
  }
}
