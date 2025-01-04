import 'package:flutter/material.dart';
import 'package:adventurize/models/user_model.dart';

class AddFriendCard extends StatelessWidget {
  final User user;
  final VoidCallback onAddFriend;

  const AddFriendCard({
    required this.user,
    required this.onAddFriend,
    Key? key,
  }) : super(key: key);

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 35,
      backgroundImage: AssetImage(user.avatarPath ?? ""),
    );
  }

  Widget _buildUsername() {
    return Text(
      user.username ?? "",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'SansitaOne',
        color: Colors.black87,
      ),
    );
  }

  Widget _buildAddFriendButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onAddFriend();
        Navigator.pop(context); // Close the popup
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
      ),
      child: Text(
        "Add Friend",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'SansitaOne',
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        margin: EdgeInsets.all(16),
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildAvatar(),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildUsername(),
                    SizedBox(height: 10),
                    _buildAddFriendButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
