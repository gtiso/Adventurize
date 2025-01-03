import 'package:flutter/material.dart';

class EditProfileCard extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController fullnameController;
  final TextEditingController emailController;
  final TextEditingController birthdateController;
  final TextEditingController passwordController;
  final String? avatarPath;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onSelectBirthdate;

  const EditProfileCard({
    required this.usernameController,
    required this.fullnameController,
    required this.emailController,
    required this.birthdateController,
    required this.passwordController,
    required this.onSave,
    required this.onCancel,
    required this.onSelectBirthdate,
    this.avatarPath,
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileCardState createState() => _EditProfileCardState();
}

class _EditProfileCardState extends State<EditProfileCard> {
  // Build top row with cancel and save buttons
  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: widget.onCancel,
          icon: const Icon(Icons.close, color: Colors.red, size: 30),
        ),
        IconButton(
          onPressed: widget.onSave,
          icon: const Icon(Icons.check, color: Colors.green, size: 30),
        ),
      ],
    );
  }

  // Build profile picture section
  Widget _buildProfilePicture() {
    return CircleAvatar(
        radius: 50,
        backgroundImage:
            widget.avatarPath != null ? AssetImage(widget.avatarPath!) : null);
  }

  // Build a single text field with the provided configurations
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool readOnly = false,
    VoidCallback? onTap,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade300, // Light gray background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label on the left
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 14,
              fontFamily: 'SansitaOne',
              color: Colors.black,
            ),
          ),
          // Input field
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              obscureText: obscureText,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'SansitaOne',
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the form fields (username, fullname, etc.)
  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField(
          controller: widget.usernameController,
          label: "USERNAME",
        ),
        const SizedBox(height: 10),
        _buildTextField(
          controller: widget.fullnameController,
          label: "FULLNAME",
        ),
        const SizedBox(height: 10),
        _buildTextField(
          controller: widget.emailController,
          label: "EMAIL",
        ),
        const SizedBox(height: 10),
        _buildTextField(
          controller: widget.birthdateController,
          label: "BIRTHDATE",
          readOnly: true,
          onTap: widget.onSelectBirthdate,
        ),
        const SizedBox(height: 10),
        _buildTextField(
          controller: widget.passwordController,
          label: "PASSWORD",
          obscureText: true, // Always obscure the text
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top row and profile picture
            Column(
              children: [
                _buildTopRow(),
                const SizedBox(height: 10),
                _buildProfilePicture(),
              ],
            ),
            const SizedBox(height: 20),
            // Form fields
            _buildFormFields(),
          ],
        ),
      ),
    );
  }
}
