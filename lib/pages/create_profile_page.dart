import 'package:flutter/material.dart';
import 'package:loginapp/classes/firestore.dart';
import 'package:loginapp/classes/user_class.dart';
import 'package:loginapp/component/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/component/profile_page_text_field.dart';
import 'package:loginapp/pages/home_page.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final FirestoreDatabase _firestoreDatabase = FirestoreDatabase();

  List<String> _skills = [];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                "Create profile",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Image.asset(
                      'lib/images/Star 8.png',
                      height: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  padding: EdgeInsets.all(33.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade300,
                  ),
                  child: Icon(Icons.file_upload_outlined),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "Profile Picture",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 15),
                            Text(
                              "First Name",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        ProfilePageTextField(
                          controller: _firstnameController,
                          hintText: "",
                          height: 50, 
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 15),
                            Text(
                              "Last Name",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        ProfilePageTextField(
                          controller: _lastnameController,
                          hintText: "",
                          height: 50, 
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

             
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        "Title",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  ProfilePageTextField(
                    controller: _titleController,
                    hintText: "",
                    height: 50,
                  ),
                ],
              ),
              SizedBox(height: 20),

             
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        "About Me",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: null, 
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Write about yourself...",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 16), 
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 15),
                            Text(
                              "Skills",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        ProfilePageTextField(
                          controller: _skillsController,
                          hintText: "",
                          height: 50, 
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          _addSkill();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.add_box_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

             
              SizedBox(height: 20),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _skills
                    .map(
                      (skill) => Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(skill),
                      ),
                    )
                    .toList(),
              ),

              SizedBox(height: 20),

              MyButton(
                onTap: () async {
                  await _createProfile();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                text: "Upload Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addSkill() {
    String skill = _skillsController.text.trim();
    if (skill.isNotEmpty) {
      setState(() {
        _skills.add(skill);
        _skillsController.clear();
      });
    }
  }

  Future<void> _createProfile() async {
    String firstName = _firstnameController.text;
    String lastName = _lastnameController.text;
    String title = _titleController.text;
    String aboutMe = _descriptionController.text;

    UserProfile userProfile = UserProfile(
      firstName: firstName,
      lastName: lastName,
      title: title,
      aboutMe: aboutMe,
      skills: _skills,
    );

    await _firestoreDatabase.createProfile(userProfile);
  }
}
