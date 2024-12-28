// import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/db_helper.dart'; // Import the database helper file
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite_common_ffi
import 'login_page.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';

import 'pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await findSystemLocale();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbHelper = DatabaseHelper();
  await dbHelper.database;

  final runnableApp = _buildRunnableApp(
    app: MyApp(),
  );

  runApp(runnableApp);
}

Widget _buildRunnableApp({required Widget app}) {
  return Center(
    child: ClipRect(
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: app,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login & Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
