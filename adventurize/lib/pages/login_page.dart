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
  bool _isPasswordVisible = false; // Variable for password visibility toggle
  late User usr;

  final DatabaseHelper db = DatabaseHelper();

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (_validateInputs(email, password)) {
      bool isAuthenticated = await _authenticateUser(email, password);

      if (isAuthenticated) {
        usr = (await db.getUsr(email))!;
        _navigateToMainPage();
      } else {
        _showSnackBar("Invalid credentials");
      }
    } else {
      _showSnackBar("Please fill all fields");
    }
  }

  bool _validateInputs(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<bool> _authenticateUser(String email, String password) async {
    return await db.auth(User(email: email, password: password));
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
      MaterialPageRoute(builder: (context) => MainPage(user: usr)),
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content:
            Text(message, style: const TextStyle(fontFamily: 'SansitaOne')),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'lib/assets/logo.png',
      height: 170,
    );
  }

  Widget _buildTitle() {
    return const Text(
      "LOGIN",
      style: TextStyle(
        fontSize: 25,
        fontFamily: 'SansitaOne',
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: "What’s your e-mail?",
        prefixIcon: Icon(Icons.email),
        labelStyle: TextStyle(fontFamily: 'SansitaOne'),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText:
          !_isPasswordVisible, // Toggle visibility based on the variable
      decoration: InputDecoration(
        labelText: "Enter your password",
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        labelStyle: const TextStyle(fontFamily: 'SansitaOne'),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton.icon(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
      icon: const Icon(
        Icons.login,
        color: Colors.white,
      ),
      label: const Text(
        "LOGIN",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'SansitaOne',
        ),
      ),
    );
  }

  Widget _buildRegisterSection() {
    return Column(
      children: [
        const Text("Don't have an account?",
            style: TextStyle(fontFamily: 'SansitaOne')),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: _navigateToRegister,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
          ),
          icon: const Icon(
            Icons.person_add,
            color: Colors.white,
          ),
          label: const Text(
            "CREATE NOW",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SansitaOne',
            ),
          ),
        ),
      ],
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
              _buildLogo(),
              _buildTitle(),
              const SizedBox(height: 30),
              _buildEmailField(),
              const SizedBox(height: 5),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildLoginButton(),
              const SizedBox(height: 30),
              _buildRegisterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
