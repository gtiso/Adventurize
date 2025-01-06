import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:adventurize/utils/navigation_utils.dart';
import 'package:adventurize/components/title.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool microphoneEnabled = false;
  bool cameraEnabled = false;
  bool navigationEnabled = false;

  @override
  void initState() {
    super.initState();
    initializePermissions();
  }

  // Initialization
  void initializePermissions() {
    checkCameraPermission();
    checkLocationPermission();
    checkMicrophonePermission();
  }

  // Permission Checkers
  Future<void> checkMicrophonePermission() async {
    updatePermissionStatus(
      permission: Permission.microphone,
      updateState: (status) => microphoneEnabled = status.isGranted,
    );
  }

  Future<void> checkCameraPermission() async {
    updatePermissionStatus(
      permission: Permission.camera,
      updateState: (status) => cameraEnabled = status.isGranted,
    );
  }

  Future<void> checkLocationPermission() async {
    updatePermissionStatus(
      permission: Permission.location,
      updateState: (status) => navigationEnabled = status.isGranted,
    );
  }

  Future<void> updatePermissionStatus({
    required Permission permission,
    required Function(PermissionStatus) updateState,
  }) async {
    var status = await permission.status;
    setState(() {
      updateState(status);
    });
  }

  // Toggle Logic
  Future<void> togglePermission({
    required bool value,
    required Permission permission,
    required String permissionType,
    required Function(bool) updateState,
  }) async {
    if (value) {
      // Enabling Permission
      var status = await permission.status;
      if (status.isPermanentlyDenied) {
        showPermissionDialog(permissionType, () {
          // If the user cancels, we do not change the state
          setState(() {});
        });
      } else {
        var requestStatus = await permission.request();
        setState(() {
          updateState(requestStatus.isGranted);
        });
      }
    } else {
      // Disabling Permission: Show dialog and decide based on user's choice
      showPermissionDialog(permissionType, () {
        // If user cancels, revert the toggle to its original state
        setState(() {
          updateState(true);
        });
      });
    }
  }

  // Permission Togglers
  Future<void> toggleMicrophonePermission(bool value) async {
    await togglePermission(
      value: value,
      permission: Permission.microphone,
      permissionType: "Microphone Permission",
      updateState: (status) => microphoneEnabled = status,
    );
  }

  Future<void> toggleCameraPermission(bool value) async {
    await togglePermission(
      value: value,
      permission: Permission.camera,
      permissionType: "Camera Permission",
      updateState: (status) => cameraEnabled = status,
    );
  }

  Future<void> toggleLocationPermission(bool value) async {
    await togglePermission(
      value: value,
      permission: Permission.location,
      permissionType: "Location Permission",
      updateState: (status) => navigationEnabled = status,
    );
  }

  // Dialog
  void showPermissionDialog(String permissionType, VoidCallback onCancel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            backgroundColor: Colors.grey[200],
            title: Text(
              permissionType,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'SansitaOne',
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            content: Text(
              '$permissionType cannot be disabled here.\n\n'
              'To disable it, you must open the app settings.\n'
              'Would you like to do that now?',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SansitaOne',
                color: Colors.grey[800],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onCancel();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SansitaOne',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: Text(
                  'Open Settings',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SansitaOne',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // UI Components
  Widget buildSettingsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSettingTile(
          icon: Icons.mic,
          title: "MICROPHONE",
          value: microphoneEnabled,
          onChanged: toggleMicrophonePermission,
        ),
        SizedBox(height: 16),
        buildSettingTile(
          icon: Icons.camera_alt,
          title: "CAMERA",
          value: cameraEnabled,
          onChanged: toggleCameraPermission,
        ),
        SizedBox(height: 16),
        buildSettingTile(
          icon: Icons.navigation,
          title: "NAVIGATION",
          value: navigationEnabled,
          onChanged: toggleLocationPermission,
        ),
      ],
    );
  }

  Widget buildVersionInfo() {
    return Column(
      children: [
        buildStaticTile("Version", "014.11.2003"),
      ],
    );
  }

  Widget buildSignOutButton() {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => NavigationUtils.navigateToLoginPage(context),
        icon: Icon(Icons.logout, color: Colors.white),
        label: Text(
          "SIGN OUT",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'SansitaOne',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildSettingTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, size: 30, color: Colors.black),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'SansitaOne',
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ],
    );
  }

  Widget buildStaticTile(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'SansitaOne',
            fontSize: 16,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'SansitaOne',
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget buildBackButton(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            Icon(Icons.arrow_back, color: Colors.black),
            SizedBox(width: 4),
            Text(
              "BACK",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'SansitaOne',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'lib/assets/logo.png',
      height: 100,
    );
  }

  Widget _buildTitle() {
    return const TitleWidget(
      icon: Icons.settings,
      text: "Settings",
    );
  }

  // Main Widget
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
              buildBackButton(context),
              _buildLogo(),
              _buildTitle(),
              buildSettingsList(),
              const SizedBox(height: 30),
              buildVersionInfo(),
              const SizedBox(height: 30),
              buildSignOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
