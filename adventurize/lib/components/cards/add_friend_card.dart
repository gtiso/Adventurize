import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:adventurize/models/user_model.dart';

class AddFriendCard extends StatefulWidget {
  final User user;
  final VoidCallback onAddFriend;

  const AddFriendCard({
    required this.user,
    required this.onAddFriend,
    Key? key,
  }) : super(key: key);

  @override
  _AddFriendCardState createState() => _AddFriendCardState();
}

class _AddFriendCardState extends State<AddFriendCard> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAddFriendCard();
  }

  Widget _buildAddFriendCard() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCard(),
        _buildConfetti(),
      ],
    );
  }

  Widget _buildCard() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: _buildCardContent(),
      ),
    );
  }

  Widget _buildCardContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 20),
          _buildUserDetails(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 35,
      backgroundImage: AssetImage(widget.user.avatarPath ?? ""),
    );
  }

  Widget _buildUserDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildUsername(),
          const SizedBox(height: 10),
          _buildAddFriendButton(),
        ],
      ),
    );
  }

  Widget _buildUsername() {
    return Text(
      widget.user.username ?? "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'SansitaOne',
        color: Colors.black87,
      ),
    );
  }

  Widget _buildAddFriendButton() {
    return ElevatedButton(
      onPressed: () => _onAddFriendPressed(context, widget.user),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.person_add,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            "Add Friend",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'SansitaOne',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _onAddFriendPressed(BuildContext context, User user) {
    widget.onAddFriend();
    _confettiController.play();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  Widget _buildConfetti() {
    return ConfettiWidget(
      confettiController: _confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      emissionFrequency: 0.05,
      numberOfParticles: 30,
      shouldLoop: false,
      colors: [Colors.blue, Colors.green, Colors.purple, Colors.pink],
    );
  }
}
