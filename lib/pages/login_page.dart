import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/component/my_button.dart';
import 'package:loginapp/component/my_textfield.dart';
import 'package:loginapp/component/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async{
    
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    },
    
    
    
    );


   try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email:usernameController.text,
   password: passwordController.text);

  Navigator.pop(context);

   } on FirebaseAuthException catch (e){
      Navigator.pop(context);


    if(e.code == 'user-not-found'){
      wrongEmailMessage();
    }
    else if(e.code == 'wrong-password'){
      wrongPasswordMessage();
    }
   }

   

  }
  void wrongEmailMessage(){
    showDialog(context: context, builder: (context){
      return const AlertDialog(
        title: Text("Incorrect Email"),


      );
    },
    
    
    );
  }

  void wrongPasswordMessage(){
    showDialog(context: context, builder: (context){
      return const AlertDialog(
        title: Text("Incorrect Password"),


      );
    },
    
    
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Icon(Icons.home, size: 100),
                  const SizedBox(height: 50),
                  const Text(
                    "Welcome back you have been missed",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 78, 78, 78),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Username text field
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),

                  // Password text field
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  // Forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),

                  // Sign in button
                  MyButton(
                    text: "Log In",

                    onTap: signUserIn,
                  ),
                  const SizedBox(height: 20),

                  // Or continue with
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or Continue with",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
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
                      SquareTile(imagePath: 'lib/images/applelogo.jpg'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Not a member? Register now
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not a Member?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                            color: Colors.blue,
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
      ),
    );
  }
}
