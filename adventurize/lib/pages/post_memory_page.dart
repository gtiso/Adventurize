import 'dart:io';
import 'package:flutter/material.dart';
import 'package:adventurize/services/location_service.dart';
import 'package:adventurize/models/memory_model.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:adventurize/utils/navigation_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class PostMemoryPage extends StatefulWidget {
  final File image;
  final User user;
  final Challenge? challenge;

  const PostMemoryPage({
    required this.image,
    required this.user,
    this.challenge,
    super.key,
  });

  @override
  State<PostMemoryPage> createState() => _PostMemoryPageState();
}

class _PostMemoryPageState extends State<PostMemoryPage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final db = DatabaseHelper();
  int _counter = 0;

  Future<void> _onPostPhotoButtonPressed() async {
    try {
      // Get the app's documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Generate a unique filename for the image
      final fileName = 'memory_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${directory.path}/$fileName';

      // Save the image to the file
      await widget.image.copy(filePath);

      debugPrint('Image saved at: $filePath');

      // Fetch the user's current location
      LatLng currentLocation = await LocationService.getUserCurrentLocation();

      final location = _locationController.text;
      final description = _descriptionController.text;
      final String formattedDate =
          DateFormat('MMMM d, y').format(DateTime.now());

      // Create a new memory instance
      final memory = Memory(
        userID: widget.user.userID ?? 0,
        userAvatarPath:
            widget.user.avatarPath ?? 'lib/assets/avatars/avatarDef.png',
        userName: widget.user.username ?? '',
        title: location.isEmpty ? 'Untitled Memory' : location,
        description: description,
        imagePath: filePath, // Use the saved image's path
        date: formattedDate,
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      );

      // Save the memory to the database
      await db.insMemory(memory);

      // Provide haptic feedback
      HapticFeedback.mediumImpact();
      setState(() {
        _counter++;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Memory posted successfully!')),
        );
      }
    } catch (e) {
      print("Error: $e");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post memory. Please try again.')),
        );
      }
    }

    User updatedUser = widget.user;
    if (widget.challenge != null) {
      // Update challenge shared
      DatabaseHelper().updateChallengeShared(
          widget.user.userID, widget.challenge?.challengeID);

      // Update the user's points
      final newPoints = widget.user.points + (widget.challenge!.points ?? 0);
      await db.updateUserPoints(widget.user.email, newPoints);
      updatedUser = updatedUser.copyWith(points: newPoints);
    }

    NavigationUtils.navigateToMainPage(context, updatedUser);
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
        onTap: () => _showTextFieldDialog(
          'Add Location',
          _locationController,
          Icons.location_on,
        ),
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
        onTap: () => _showTextFieldDialog(
          'Description',
          _descriptionController,
          Icons.edit,
        ),
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

  void _showTextFieldDialog(
      String title, TextEditingController controller, IconData titleIcon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            Icon(
              titleIcon,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'SansitaOne',
              ),
            ),
          ],
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: title,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[900],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CANCEL',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontFamily: 'SansitaOne',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'SansitaOne',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
