import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/classes/firestore.dart';
import 'package:loginapp/classes/user_class.dart';
import 'package:loginapp/pages/edit_page.dart';
import 'package:loginapp/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void gotoEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPage()),
    );
  }

  Widget buildCoverImage() => Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/newgalaxy.png'),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget buildProfileImage() => Positioned(
        top: 195, 
        right:110,
        child: CircleAvatar(
          backgroundImage: AssetImage('lib/images/swag.JPG'),
          radius: 60,
        ),
      );

  @override
  Widget build(BuildContext context) {
    FirestoreDatabase db = FirestoreDatabase();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            buildCoverImage(),
      
            Container(
              margin: EdgeInsets.only(top: 300), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: db.getProfileInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return Center(child: Text("No profile data found"));
                        }
                        UserProfile userProfile =
                            UserProfile.fromMap(snapshot.data!.data() as Map<String, dynamic>);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${userProfile.firstName} ${userProfile.lastName}",
                              style:
                                  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${userProfile.title}",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "About Me",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${userProfile.aboutMe}",
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Skills",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: userProfile.skills
                                  .map((skill) => Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Text(skill),
                                      ))
                                  .toList(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        onPressed: signUserOut,
                        icon: const Icon(Icons.exit_to_app),
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () => gotoEdit(context),
                      icon: Icon(Icons.edit),
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            buildProfileImage(), 
          ],
        ),
  
      ),
    );
  }
}
