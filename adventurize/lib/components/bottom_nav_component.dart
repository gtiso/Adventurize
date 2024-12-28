import 'package:flutter/material.dart';

class BottomNavComponent extends StatelessWidget {
  final int currentIndex; // Receive current index from parent
  final Function(int)
      onItemSelected; // Callback for parent to handle page change

  const BottomNavComponent({
    required this.currentIndex,
    required this.onItemSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Background color for the button row
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.diamond,
              color: currentIndex == 0 ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              onItemSelected(0); // Notify parent of button press
            },
          ),
          IconButton(
            icon: Icon(
              Icons.people,
              color: currentIndex == 1 ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              onItemSelected(1); // Notify parent of button press
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              color: currentIndex == 2 ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              onItemSelected(2); // Notify parent of button press
            },
          ),
        ],
      ),
    );
  }
}
