import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  void _selectBirthdate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _birthdateController.text = DateFormat('yMd').format(pickedDate);
      });
    }
  }

  void _register() async {
    String emailFromInput = _emailController.text;
    String passwordFromInput = _passwordController.text;
    String fullnameFromInput = _fullnameController.text;
    String birthdateFromInput = _birthdateController.text;

    final db = DatabaseHelper();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    if (emailFromInput.isNotEmpty &&
        passwordFromInput.isNotEmpty &&
        fullnameFromInput.isNotEmpty &&
        birthdateFromInput.isNotEmpty) {
      if (!mounted) return;
      int userId = await db.createUsr(Users(
          birthdate: birthdateFromInput,
          fullname: fullnameFromInput,
          email: emailFromInput,
          password: passwordFromInput,
          username: fullnameFromInput.trimLeft()));
      print("New UserID : ");
      print(userId);
      _navigateToMainPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(seconds: 1),
            content: Text("Please fill all fields")),
      );
    }
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _navigateToMainPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/logo.png',
                height: 170,
              ),
              Text("REGISTER", style: TextStyle(fontSize: 25)),
              SizedBox(height: 25),
              TextField(
                controller: _fullnameController,
                decoration: InputDecoration(
                  labelText: "Enter your Full Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "What's your email?",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _birthdateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "When were you born?",
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                onTap: _selectBirthdate,
              ),
              SizedBox(height: 5),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Create a password",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _register,
                child: Text("REGISTER"),
              ),
              SizedBox(height: 40),
              Text("Already have an account?"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _navigateToLogin,
                child: Text("LOGIN"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
