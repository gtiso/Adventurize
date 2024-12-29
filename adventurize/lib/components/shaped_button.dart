import 'package:flutter/material.dart';

class ShapedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ShapedButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 90,
        height: 90, 
        decoration: BoxDecoration(
          shape: BoxShape.circle, 
          border: Border.all(
            color: Colors.black, 
            width: 6.5, 
          ),
        ),
      ),
    );
  }
}
