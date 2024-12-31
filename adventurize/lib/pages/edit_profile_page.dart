import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adventurize/components/cards/profile_edit_card.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

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
    _usernameController = TextEditingController(text: "george123");
    _fullnameController = TextEditingController(text: "George George");
    _emailController = TextEditingController(text: "george123@mail.com");
    _birthdateController = TextEditingController(text: "09/12/2003");
    _passwordController = TextEditingController(text: "********");
  }

  Widget _buildMapBackground() {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(36.1627, -86.7816), // Example coordinates
        zoom: 12.0,
      ),
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
    );
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
      body: Stack(
        children: [
          _buildMapBackground(),
          Container(
            color: Colors.white.withOpacity(0.6),
          ),
          Center(
            child: EditProfileCard(
              usernameController: _usernameController,
              fullnameController: _fullnameController,
              emailController: _emailController,
              birthdateController: _birthdateController,
              passwordController: _passwordController,
              onSave: _saveProfile,
              onCancel: () {
                Navigator.pop(context); // Navigate back to the previous page
              },
              onSelectBirthdate: _selectBirthdate,
            ),
          ),
        ],
      ),
    );
  }
}
