import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool initialObscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.initialObscureText,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.initialObscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 18,
              ),
              onPressed: _toggleObscureText,
            ),
          ],
        ),
      ),
    );
  }
}
