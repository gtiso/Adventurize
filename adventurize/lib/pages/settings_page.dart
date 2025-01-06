import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:adventurize/utils/navigation_utils.dart';

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
    checkCameraPermission();
    checkLocationPermission();
    checkMicrophonePermission();
  }

  // ------------------ MICROPHONE LOGIC ------------------
  Future<void> checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    setState(() {
      microphoneEnabled = status.isGranted;
    });
  }

  Future<void> toggleMicrophonePermission(bool value) async {
    if (value) {
      // User is trying to enable microphone
      var status = await Permission.microphone.status;
      if (status.isPermanentlyDenied) {
        _showSettingsDialog("Microphone Permission", () {
          setState(() {
            microphoneEnabled = false;
          });
        });
      } else {
        var requestStatus = await Permission.microphone.request();
        setState(() {
          microphoneEnabled = requestStatus.isGranted;
        });
      }
    } else {
      // User is turning microphone off in the UI
      setState(() {
        microphoneEnabled = false;
      });
      _showSettingsDialog("Microphone Permission", () {
        setState(() {
          microphoneEnabled = true;
        });
      });
    }
  }

  // ------------------ CAMERA LOGIC ----------------------
  Future<void> checkCameraPermission() async {
    var status = await Permission.camera.status;
    setState(() {
      cameraEnabled = status.isGranted;
    });
  }

  Future<void> toggleCameraPermission(bool value) async {
    if (value) {
      var status = await Permission.camera.status;
      if (status.isPermanentlyDenied) {
        _showSettingsDialog("Camera Permission", () {
          setState(() {
            cameraEnabled = false;
          });
        });
      } else {
        var requestStatus = await Permission.camera.request();
        setState(() {
          cameraEnabled = requestStatus.isGranted;
        });
      }
    } else {
      setState(() {
        cameraEnabled = false;
      });
      _showSettingsDialog("Camera Permission", () {
        setState(() {
          cameraEnabled = true;
        });
      });
    }
  }

  // ------------------ LOCATION LOGIC --------------------
  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;
    setState(() {
      navigationEnabled = status.isGranted;
    });
  }

  Future<void> toggleLocationPermission(bool value) async {
    if (value) {
      var status = await Permission.location.status;
      if (status.isPermanentlyDenied) {
        _showSettingsDialog("Location Permission", () {
          setState(() {
            navigationEnabled = false;
          });
        });
      } else {
        var requestStatus = await Permission.location.request();
        setState(() {
          navigationEnabled = requestStatus.isGranted;
        });
      }
    } else {
      setState(() {
        navigationEnabled = false;
      });
      _showSettingsDialog("Location Permission", () {
        setState(() {
          navigationEnabled = true;
        });
      });
    }
  }

  // ------------------ POPUP DIALOG ----------------------
  void _showSettingsDialog(String permissionType, VoidCallback onCancel) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent tap outside to dismiss
      builder: (context) {
        return WillPopScope(
          // Prevent back-button to dismiss
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(permissionType),
            content: Text(
              '$permissionType has been permanently disabled.\n\n'
              'To enable it again, you must open the app settings.\n'
              'Would you like to do that now?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  onCancel(); // Revert the toggle state if needed
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  openAppSettings(); // Open system app settings
                },
                child: Text('Open Settings'),
              ),
            ],
          ),
        );
      },
    );
  }

  // ------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
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
        ),
        leadingWidth: 120,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Use a Column with extra spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSettingsList(),
              SizedBox(height: 30), // Extra spacing to make the screen fuller
              buildVersionInfo(),
              SizedBox(height: 40), // Even more space before sign out
              buildSignOutButton(),
            ],
          ),
        ),
      ),
    );
  }

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

  // Only shows version now
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
        onPressed: () {
          NavigationUtils.navigateToLoginPage(context);
        },
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
          activeColor: Colors.purple,
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
}
