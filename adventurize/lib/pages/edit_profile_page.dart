import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:adventurize/components/map_background.dart';
import 'package:intl/intl.dart';
import 'package:adventurize/components/cards/profile_edit_card.dart';
import 'package:adventurize/navigation_utils.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _fullnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthdateController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _usernameController = TextEditingController(text: widget.user.username);
    _fullnameController = TextEditingController(text: widget.user.fullname);
    _emailController = TextEditingController(text: widget.user.email);
    _birthdateController = TextEditingController(text: widget.user.birthdate);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  void _selectBirthdate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _birthdateController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
      });
    }
  }

  void _saveProfile() {
    debugPrint("Username: ${_usernameController.text}");
    debugPrint("Fullname: ${_fullnameController.text}");
    debugPrint("Email: ${_emailController.text}");
    debugPrint("Birthdate: ${_birthdateController.text}");
    debugPrint("Password: ${_passwordController.text}");

    User updatedUser = User(
        userID: widget.user.userID,
        password: _passwordController.text,
        email: _emailController.text,
        username: _usernameController.text,
        fullname: _fullnameController.text,
        birthdate: _birthdateController.text,
        avatarPath: widget.user.avatarPath,
        points: widget.user.points);

    DatabaseHelper().saveProfileToDB(updatedUser);
    NavigationUtils.navigateToProfile(context, updatedUser);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Saved Successfully!")),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _birthdateController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const MapBackground(),
          Center(
            child: EditProfileCard(
              usernameController: _usernameController,
              fullnameController: _fullnameController,
              emailController: _emailController,
              birthdateController: _birthdateController,
              passwordController: _passwordController,
              avatarPath: widget.user.avatarPath,
              onSave: _saveProfile,
              onCancel: () {
                Navigator.pop(context);
              },
              onSelectBirthdate: _selectBirthdate,
            ),
          )
        ],
      ),
    );
  }
}
