import 'dart:io';
import 'package:flutter/material.dart';

class PostMemoryPage extends StatefulWidget {
  final File image;

  PostMemoryPage({required this.image});

  @override
  _PostMemoryPageState createState() => _PostMemoryPageState();
}

class _PostMemoryPageState extends State<PostMemoryPage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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

  void _onPostPhotoButtonPressed() {
    final location = _locationController.text;
    final description = _descriptionController.text;
    print('Location: $location');
    print('Description: $description');
    // Further actions with location and description
  }
}
