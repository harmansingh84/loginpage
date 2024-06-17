import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
   HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;


  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.exit_to_app))



      ],),
      body: Center(child:  Text("Logged In As: "+ user.email!,
      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
      
      
      )),



    );
  }
}