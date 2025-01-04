import 'dart:io';
import 'package:flutter/material.dart';
import 'package:adventurize/services/location_service.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:adventurize/navigation_utils.dart';

class PostMemoryPage extends StatefulWidget {
  final File image;
  final User user;
  final Challenge? challenge;

  const PostMemoryPage({
    required this.image,
    required this.user,
    this.challenge,
    Key? key,
  }) : super(key: key);

  @override
  _PostMemoryPageState createState() => _PostMemoryPageState();
}

class _PostMemoryPageState extends State<PostMemoryPage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final db = DatabaseHelper();

  void _onPostPhotoButtonPressed() async {
    try {
      if (widget.challenge != null) {
        debugPrint("Challenge details: ${widget.challenge!.toMap()}");
      } else {
        debugPrint("No challenge provided.");
      }

      // Fetch the user's current location
      LatLng currentLocation = await LocationService.getUserCurrentLocation();

      final location = _locationController.text;
      final description = _descriptionController.text;
      final String formattedDate =
          DateFormat('MMMM d, y').format(DateTime.now());

      // Create a new memory instance
      final memory = Memory(
        userID: widget.user.userID ?? 0,
        userAvatarPath: widget.user.avatarPath ?? '',
        userName: widget.user.username ?? '',
        title: location.isEmpty ? 'Untitled Memory' : location,
        description: description,
        imagePath: widget.image.path,
        date: formattedDate,
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      );

      // Save the memory to the database
      await db.insMemory(memory);

      if (widget.challenge != null) {
        // Create a new challenge instance with updated shared status
        Challenge updatedChallenge = Challenge(
          challengeID: widget.challenge!.challengeID,
          title: widget.challenge!.title,
          desc: widget.challenge!.desc,
          photoPath: widget.challenge!.photoPath,
          points: widget.challenge!.points,
          shared: 1, // Set shared to 1
        );

        // Save the updated challenge to the database
        DatabaseHelper().saveChallengeToDB(updatedChallenge);

        debugPrint(
            "Challenge marked as completed: ${updatedChallenge.challengeID}, shared status: ${updatedChallenge.shared}");
      }

      if (mounted) {
        // Check if the widget is still mounted
        // Provide feedback to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Memory posted successfully!')),
        );

        // Navigate back to the main page
        NavigationUtils.navigateToMainPage(context, widget.user);
      }
    } catch (e) {
      print("Error: $e");

      if (mounted) {
        // Check if the widget is still mounted
        // Provide feedback to the user in case of an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post memory. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildCapturedPhoto(),
          _buildCloseButton(context),
          _buildBottomActionArea(),
        ],
      ),
    );
  }

  Widget _buildCapturedPhoto() => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: FileImage(widget.image),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _buildCloseButton(BuildContext context) => Positioned(
        top: 20,
        right: 20,
        child: GestureDetector(
          onTap: _onCloseButtonTap,
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 30,
          ),
        ),
      );

  void _onCloseButtonTap() => Navigator.pop(context);

  Widget _buildBottomActionArea() => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAddLocationField(),
              SizedBox(height: 16),
              _buildDescriptionField(),
              SizedBox(height: 16),
              _buildPostPhotoButton(),
            ],
          ),
        ),
      );

  Widget _buildAddLocationField() => GestureDetector(
        onTap: () => _showTextFieldDialog('Add Location', _locationController),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.black,
              ),
              SizedBox(width: 8),
              Text(
                _locationController.text.isEmpty
                    ? 'Add Location'
                    : _locationController.text,
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

  Widget _buildDescriptionField() => GestureDetector(
        onTap: () =>
            _showTextFieldDialog('Description Field', _descriptionController),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              _descriptionController.text.isEmpty
                  ? 'DESCRIPTION FIELD'
                  : _descriptionController.text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'SansitaOne',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

  Widget _buildPostPhotoButton() => ElevatedButton(
        onPressed: _onPostPhotoButtonPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'POST PHOTO',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'SansitaOne',
          ),
        ),
      );

  void _showTextFieldDialog(String title, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: title),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
