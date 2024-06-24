import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyCustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const MyCustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  _MyCustomTextFieldState createState() => _MyCustomTextFieldState();
}

class _MyCustomTextFieldState extends State<MyCustomTextField> {
  bool showCheckMark = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final text = widget.controller.text.toLowerCase();
      if (text.endsWith("@gmail.com")) {
        setState(() {
          showCheckMark = true;
        });
      } else {
        setState(() {
          showCheckMark = false;
        });
      }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1), 
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20), 
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                ),
              ),
            ),
            if (showCheckMark)
              const Icon(
                Icons.check_circle,
                size: 18,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
          ],
        ),
      ),
    );
  }
}
