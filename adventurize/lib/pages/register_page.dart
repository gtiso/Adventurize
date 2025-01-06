import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  bool _isPasswordVisible = false; // Variable to toggle password visibility
  late User usr;

  void _selectBirthdate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'SansitaOne',
                ),
            colorScheme: ColorScheme.light(primary: Colors.blue),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _birthdateController.text = DateFormat('yMd').format(pickedDate);
      });
    } else {
      _showSnackBar("No date selected");
    }
  }

  Future<void> _register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String fullname = _fullnameController.text;
    String birthdate = _birthdateController.text;

    if (_validateInputs(email, password, fullname, birthdate)) {
      int userID = await _createUser(email, password, fullname, birthdate);

      usr.userID = userID;
      debugPrint("New UserID : ${usr.userID}");
      NavigationUtils.navigateToMainPage(context, usr);
    } else {
      _showSnackBar("Please fill all fields");
    }
  }

  bool _validateInputs(
      String email, String password, String fullname, String birthdate) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        fullname.isNotEmpty &&
        birthdate.isNotEmpty;
  }

  Future<int> _createUser(
      String email, String password, String fullname, String birthdate) async {
    final db = DatabaseHelper();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    usr = User(
      birthdate: birthdate,
      fullname: fullname,
      email: email,
      password: password,
      username: fullname.trimLeft(),
      avatarPath: 'lib/assets/avatars/avatarDef.png',
    );

    return await db.createUsr(usr);
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
      height: 150,
    );
  }

  Widget _buildTitle() {
    return const Text(
      "REGISTER",
      style: TextStyle(
        fontSize: 25,
        fontFamily: 'SansitaOne',
      ),
    );
  }

  Widget _buildFullNameField() {
    return TextField(
      controller: _fullnameController,
      decoration: const InputDecoration(
        labelText: "Enter your Full Name",
        prefixIcon: Icon(Icons.person),
        labelStyle: TextStyle(fontFamily: 'SansitaOne'),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: "What's your email?",
        prefixIcon: Icon(Icons.email),
        labelStyle: TextStyle(fontFamily: 'SansitaOne'),
      ),
    );
  }

  Widget _buildBirthdateField() {
    return TextField(
      controller: _birthdateController,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: "When were you born?",
        prefixIcon: Icon(Icons.calendar_month),
        labelStyle: TextStyle(fontFamily: 'SansitaOne'),
      ),
      onTap: _selectBirthdate,
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible, // Toggle visibility based on state
      decoration: InputDecoration(
        labelText: "Create a password",
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

  Widget _buildRegisterButton() {
    return ElevatedButton.icon(
      onPressed: _register,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(
        Icons.app_registration,
        color: Colors.white,
      ),
      label: const Text(
        "REGISTER",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'SansitaOne',
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLoginSection() {
    return Column(
      children: [
        const Text("Already have an account?",
            style: TextStyle(fontFamily: 'SansitaOne')),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            NavigationUtils.navigateToLoginPage(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: Icon(
            Icons.login,
            color: Colors.white,
          ),
          label: const Text(
            "LOGIN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'SansitaOne',
              color: Colors.white,
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
              const SizedBox(height: 5),
              _buildFullNameField(),
              const SizedBox(height: 5),
              _buildEmailField(),
              const SizedBox(height: 5),
              _buildBirthdateField(),
              const SizedBox(height: 5),
              _buildPasswordField(),
              const SizedBox(height: 5),
              _buildRegisterButton(),
              const SizedBox(height: 5),
              _buildLoginSection(),
            ],
          ),
        ),
      ),
    );
  }
}
