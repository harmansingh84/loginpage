import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/component/email_text_field.dart';
import 'package:loginapp/component/my_button.dart';
import 'package:loginapp/component/my_textfield.dart';
import 'package:loginapp/component/square_tile.dart';
import 'package:loginapp/pages/create_profile_page.dart';
import 'package:loginapp/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

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
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        Navigator.pop(context); 

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CreateProfilePage()),
        );
      } else {
        Navigator.pop(context); 
        wrongPasswordMessage();
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); 

      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      } else {
        
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
                          const Text("Email"),
                        ],
                      ),
                      
                      MyCustomTextField(controller: usernameController, hintText: "example@gmail.com"),

                      const SizedBox(height: 20),
                      
                      Row(
                        children: [
                          const Text("Create a password"),
                        ],
                      ),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'must be 8 characters',
                        initialObscureText: true,
                      ),
                      const SizedBox(height: 20),
                      
                      Row(
                        children: [
                          const Text("Confirm password"),
                        ],
                      ),
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'repeat password',
                        initialObscureText: true,
                      ),
                      const SizedBox(height: 30),
                     
                      MyButton(
                        text: "Register",
                        onTap: signUserUp,
                      ),
                      const SizedBox(height: 20),
                     
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
                      
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareTile(imagePath: 'lib/images/googlelogo.png'),
                          SizedBox(width: 25),
                          SquareTile(imagePath: 'lib/images/apple.png'),
                        ],
                      ),
                      const SizedBox(height: 50),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: const Text(
                              "Login",
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
