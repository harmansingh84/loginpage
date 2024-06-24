import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {//so everytime we use on tap we need to include final Function()? onTap;
  final Function()? onTap;
  final String text;
  const MyButton({super.key,
    required this.onTap,
    required this.text,
    });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(13.2),
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          decoration: BoxDecoration(color: Colors.black,
          borderRadius: BorderRadius.circular(10.1),
          ),
          child: Center(child:Text(text,
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          ),)),
          
        
        
        
          ),
      ),
    );


   
  }
}