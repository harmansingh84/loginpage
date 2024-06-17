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
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          decoration: BoxDecoration(color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child:Text(text,//we will wrap this in a gesture detector so it can be a button 
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          ),)),
          
        
        
        
          ),
      ),
    );


   
  }
}