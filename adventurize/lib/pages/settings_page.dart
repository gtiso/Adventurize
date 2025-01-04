import 'package:flutter/material.dart';
import 'package:adventurize/utils/navigation_utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool soundsEnabled = true;
  bool hapticsEnabled = true;
  bool cameraEnabled = true;
  bool navigationEnabled = true;

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
              SizedBox(height: 5), // Add spacing before the Sign Out button
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
          onChanged: (value) {
            setState(() {
              notificationsEnabled = value;
            });
          },
        ),
        buildSettingTile(
          icon: Icons.volume_up,
          title: "SOUNDS",
          value: soundsEnabled,
          onChanged: (value) {
            setState(() {
              soundsEnabled = value;
            });
          },
        ),
        buildSettingTile(
          icon: Icons.vibration,
          title: "HAPTICS",
          value: hapticsEnabled,
          onChanged: (value) {
            setState(() {
              hapticsEnabled = value;
            });
          },
        ),
        buildSettingTile(
          icon: Icons.camera_alt,
          title: "CAMERA",
          value: cameraEnabled,
          onChanged: (value) {
            setState(() {
              cameraEnabled = value;
            });
          },
        ),
        buildSettingTile(
          icon: Icons.navigation,
          title: "NAVIGATION",
          value: navigationEnabled,
          onChanged: (value) {
            setState(() {
              navigationEnabled = value;
            });
          },
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
                color: Colors.grey[300], // Gray background color for text
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
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
