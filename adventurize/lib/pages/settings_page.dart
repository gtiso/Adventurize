import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:adventurize/utils/navigation_utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool soundsEnabled = true;
  bool hapticsEnabled = true;
  bool cameraEnabled = false; // Default to false
  bool navigationEnabled = false; // Default to false

  @override
  void initState() {
    super.initState();
    checkCameraPermission();
    checkLocationPermission();
    checkNotificationPermission();
  }

  Future<void> checkCameraPermission() async {
    var status = await Permission.camera.status;
    setState(() {
      cameraEnabled = status.isGranted;
    });
  }

  Future<void> toggleCameraPermission(bool value) async {
    if (value) {
      var status = await Permission.camera.request();
      setState(() {
        cameraEnabled = status.isGranted;
      });
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
            navigationEnabled = false; // Revert the toggle state
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

  Future<void> checkNotificationPermission() async {
    var status = await Permission.notification.status;
    setState(() {
      notificationsEnabled = status.isGranted;
    });
  }

  Future<void> toggleNotificationPermission(bool value) async {
    if (value) {
      var status = await Permission.notification.request();
      setState(() {
        notificationsEnabled = status.isGranted;
      });
    } else {
      setState(() {
        notificationsEnabled = false;
      });
      _showSettingsDialog("Notification Permission", () {
        setState(() {
          notificationsEnabled = true;
        });
      });
    }
  }

  void toggleSounds(bool value) {
    setState(() {
      soundsEnabled = value;
    });
    if (!value) {
      _showSettingsDialog("Sounds", () {
        setState(() {
          soundsEnabled = true;
        });
      });
    }
  }

  void toggleHaptics(bool value) {
    setState(() {
      hapticsEnabled = value;
    });
    if (!value) {
      _showSettingsDialog("Haptics", () {
        setState(() {
          hapticsEnabled = true;
        });
      });
    }
  }

  void _showSettingsDialog(String permissionType, VoidCallback onCancel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$permissionType'),
          content: Text(
              '$permissionType has been permanently disabled. To enable it again, you must open the app settings. Would you like to do that now?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                onCancel(); // Revert the toggle state
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSettingsList(),
              SizedBox(height: 5),
              buildStaticInfo(),
              SizedBox(height: 5),
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
          icon: Icons.notifications,
          title: "NOTIFICATIONS",
          value: notificationsEnabled,
          onChanged: toggleNotificationPermission,
        ),
        buildSettingTile(
          icon: Icons.volume_up,
          title: "SOUNDS",
          value: soundsEnabled,
          onChanged: toggleSounds,
        ),
        buildSettingTile(
          icon: Icons.vibration,
          title: "HAPTICS",
          value: hapticsEnabled,
          onChanged: toggleHaptics,
        ),
        buildSettingTile(
          icon: Icons.camera_alt,
          title: "CAMERA",
          value: cameraEnabled,
          onChanged: toggleCameraPermission,
        ),
        buildSettingTile(
          icon: Icons.navigation,
          title: "NAVIGATION",
          value: navigationEnabled,
          onChanged: toggleLocationPermission,
        ),
      ],
    );
  }

  Widget buildStaticInfo() {
    return Column(
      children: [
        buildStaticTile("Version", "014.11.2003"),
        buildStaticTile("About", "Coming Soon!"),
        buildStaticTile("App Policy", "Coming Soon!"),
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
        icon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.black),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
      ),
    );
  }

  Widget buildStaticTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
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
      ),
    );
  }
}
