import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 252, 252, 252),
      ),
      child: Image.asset(
        imagePath,
        height: 20, 
        width: 60,  
        // the image fits within the container
      ),
    );
  }
}
