import 'package:adventurize/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _addDummyData();
  final runnableApp = _buildRunnableApp(
    app: MyApp(),
  );

  runApp(runnableApp);
}

Future<void> _addDummyData() async {
  await DatabaseHelper().insDemoData();
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
      home: LoginPage(),
    );
  }
}
