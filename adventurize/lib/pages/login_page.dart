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

    if (emailFromInput.isNotEmpty && passwordFromInput.isNotEmpty) {
      var res = await db
          .auth(User(email: emailFromInput, password: passwordFromInput));

      if (res) {
        if (!mounted) return;
        _navigateToMainPage();
      } else {
        if (!mounted) return;
        _showSnackBar("Invalid credentials");
      }
    } else {
      if (!mounted) return;
      _showSnackBar("Please fill all fields");
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              const Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'SansitaOne',
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "What’s your e-mail?",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Enter your password",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                child: const Text("LOGIN"),
              ),
              const SizedBox(height: 60),
              const Text("Don't have an account?"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _navigateToRegister,
                child: const Text("CREATE NOW"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
