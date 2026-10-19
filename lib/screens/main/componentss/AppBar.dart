import 'package:Doctors/utils/color.dart';
import 'package:flutter/material.dart';

class AppBar extends StatelessWidget {
  const AppBar({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style: TextStyle(color: colorFromHex("8696BB"), fontSize: 16),
            ),
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        Image.asset("assets/images/user.png", width: 56, height: 56),
      ],
    );
  }
}
