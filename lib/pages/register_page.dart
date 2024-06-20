import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/component/email_text_field.dart';
import 'package:loginapp/component/my_button.dart';
import 'package:loginapp/component/my_textfield.dart';
import 'package:loginapp/component/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
      } else {
        wrongPasswordMessage();
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Email"),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Password"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'lib/images/Star 8.png',
                  height: 40,
                ),
              ),
            ),
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      const Row(
                        children: [
                          Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Text("Email ",
                          ),
                        ],
                      ),
                      // Username text field
                      MyCustomTextField(controller: usernameController, hintText: "example@gmail.com"),

                      const SizedBox(height: 20),
                      // Password text field
                      Row(
                        children: [
                          Text("Create a password",
                          ),
                        ],
                      ),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'must be 8 characters',
                        initialObscureText: true,
                      ),
                      const SizedBox(height: 20),
                      // Confirm Password text field
                      Row(
                        children: [
                          Text("confirm password",
                          ),
                        ],
                      ),
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'repeat password',
                        initialObscureText: true,
                      ),
                      // Forgot password
                      SizedBox(height: 30),
                      // Sign up button
                      MyButton(
                        text: "Register",
                        onTap: signUserUp,
                      ),
                      const SizedBox(height: 20),
                      // Or continue with
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Or Register with",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Google + Apple sign in buttons
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareTile(imagePath: 'lib/images/googlelogo.png'),
                          SizedBox(width: 25),
                          SquareTile(imagePath: 'lib/images/apple.png'),
                        ],
                      ),
                      const SizedBox(height: 50),
                      // Already have an account? Log in
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
