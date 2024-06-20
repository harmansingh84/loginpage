import 'package:flutter/material.dart';

class ProfilePageTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double? width;
  final double height;

  const ProfilePageTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10), // Same padding as the button
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10), // Match button padding
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
