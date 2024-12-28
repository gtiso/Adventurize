import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/db_helper.dart'; // Import the database helper file
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite_common_ffi

import 'pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter is initialized before database setup

  // Initialize sqflite for desktop platforms
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // Initialize the database
  final dbHelper = DatabaseHelper();
  await dbHelper.database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
