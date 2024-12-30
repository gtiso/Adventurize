import 'package:adventurize/pages/challenges_page.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:adventurize/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      title: 'Adventurize',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
