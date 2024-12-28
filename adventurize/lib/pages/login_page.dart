import 'package:flutter/material.dart';
import 'register_page.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final db = DatabaseHelper();

  void _login() async {
    String emailFromInput = _emailController.text;
    String passwordFromInput = _passwordController.text;

    // Users? usrDetails = await db.getUser(emailFromInput);
    var res = await db.authenticate(
        Users(email: emailFromInput, password: passwordFromInput));

    if (res) {
      if (!mounted) return;
      _navigateToMainPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(seconds: 1),
            content: Text("Invalid credentials")),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
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
              Text("LOGIN", style: TextStyle(fontSize: 25)),
              SizedBox(height: 50),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "What’s your e-mail?",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Enter your password",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                child: Text("LOGIN"),
              ),
              SizedBox(height: 60),
              Text("Don't have an account?"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _navigateToRegister,
                child: Text("CREATE NOW"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
