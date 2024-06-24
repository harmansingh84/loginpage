import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/pages/home_page.dart';
import 'package:loginapp/pages/login_or_register.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),//if the user is logged in or not
      builder: (context, snapshot){
        if(snapshot.hasData){
          return const HomePage();
        }
        else{
          return const LoginOrRegister();
        }
      },
      )


    );
  }
}

class LoginOrRegisterPage {
}