import 'package:flutter/material.dart';
import 'package:loginapp/pages/login_page.dart';
import 'package:loginapp/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: const LoginPage(), 
        bottomNavigationBar: TextButton(
          onPressed: togglePages,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "Sign up",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: const RegisterPage(), 
        bottomNavigationBar: TextButton(
          onPressed: togglePages,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "Log in",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
