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
import 'package:adventurize/utils/animated_transitions.dart';
import 'dart:io';

class NavigationUtils {
  static void handleHorizontalDragMain(
      BuildContext context, DragEndDetails details, User user) {
    if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
      // Swiped right
      NavigationUtils.navigateToChallenges(context, user);
    } else if (details.primaryVelocity != null &&
        details.primaryVelocity! < 0) {
      // Swiped left
      NavigationUtils.navigateToMemoryHistory(context, user);
    }
  }

  static void handleVerticalDragMain(
      BuildContext context, DragEndDetails details, User user) {
    if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
      // Swiped down
      NavigationUtils.navigateToProfile(context, user);
    } else if (details.primaryVelocity != null &&
        details.primaryVelocity! < 0) {
      // Swiped up
      NavigationUtils.navigateToLeaderboard(context, user);
    }
  }

  static void handleHorizontalDragMemoryHistory(
      BuildContext context, DragEndDetails details, User user) {
    if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
      // Swiped right
      NavigationUtils.navigateToMainPage(context, user);
    }
  }

  static void handleHorizontalDragChallenges(
      BuildContext context, DragEndDetails details, User user) {
    if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
      // Swiped left
      NavigationUtils.navigateToMainPage(context, user);
    }
  }

  static void handleVerticalDragProfile(
      BuildContext context, DragEndDetails details, User user) {
    if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
      // Swiped up
      NavigationUtils.navigateToMainPage(context, user);
    }
  }

  static void handleVerticalDragLeaderboard(
      BuildContext context, DragEndDetails details, User user) {
    if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
      // Swiped down
      NavigationUtils.navigateToMainPage(context, user);
    }
  }

  static void navigateToProfile(BuildContext context, User user) {
    Navigator.of(context).push(
      AnimatedTransitions.createSlideTransition(
        MyProfilePage(user: user),
        begin: Offset(0.0, -1.0),
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  static void navigateToChallenges(BuildContext context, User user) {
    Navigator.of(context).push(
      AnimatedTransitions.createSlideTransition(
        ChallengesPage(user: user),
        begin: Offset(-1.0, 0.0),
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  static void navigateToLeaderboard(BuildContext context, User user) {
    Navigator.of(context).push(
      AnimatedTransitions.createSlideTransition(
        LeaderboardPage(user: user),
        begin: Offset(0.0, 1.0),
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  static void navigateToMemoryHistory(BuildContext context, User user) {
    Navigator.of(context).push(
      AnimatedTransitions.createSlideTransition(
        MemoryHistoryPage(user: user),
        begin: Offset(1.0, 0.0),
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  static void navigateToCamera(
      BuildContext context, User user, Challenge? challenge) {
    Navigator.of(context).push(
      AnimatedTransitions.createFadeTransition(
        CameraPage(user: user, challenge: challenge),
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 150),
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
