import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const TitleWidget({
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.black),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 30, fontFamily: 'SansitaOne'),
          ),
          SizedBox(width: 10),
          Icon(icon, size: 30, color: Colors.black),
        ],
      ),
    );
  }
}
