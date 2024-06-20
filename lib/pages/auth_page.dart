import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/pages/create_profile_page.dart';
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
          return CreateProfilePage();
        }
        else{
          return LoginOrRegister();
        }
      },
      )


    );
  }
}

class LoginOrRegisterPage {
}