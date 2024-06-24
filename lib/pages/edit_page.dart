import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/classes/firestore.dart';
import 'package:loginapp/classes/user_class.dart';
import 'package:loginapp/component/my_button.dart';
import 'package:loginapp/component/profile_page_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/pages/home_page.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final FirestoreDatabase _firestoreDatabase = FirestoreDatabase();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() async {
    setState(() {
      isLoading = true;
    });
    try {
      DocumentSnapshot snapshot = (await _firestoreDatabase.getProfileInfo()) as DocumentSnapshot<Object?>;
      if (snapshot.exists) {
        UserProfile userProfile = UserProfile.fromMap(snapshot.data() as Map<String, dynamic>);
        _firstnameController.text = userProfile.firstName;
        _lastnameController.text = userProfile.lastName;
        _titleController.text = userProfile.title;
        _descriptionController.text = userProfile.aboutMe;
        _skillsController.text = userProfile.skills.join(', ');
      }
    } catch (e) {
      print('Error loading profile data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Edit profile",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    SizedBox(height: 20),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                              Text(
                                "Last Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                        Text(
                          "Title",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                        Text(
                          "About Me",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        ProfilePageTextField(
                          controller: _descriptionController,
                          hintText: "",
                          height: 150,
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
                              Text(
                                "Skills",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                            Container(
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
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    MyButton(
                      onTap: () async {
                        await _updateProfile();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      text: "Update Profile",
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _updateProfile() async {
    String firstName = _firstnameController.text;
    String lastName = _lastnameController.text;
    String title = _titleController.text;
    String aboutMe = _descriptionController.text;
    List<String> skills = _skillsController.text.split(',').map((s) => s.trim()).toList();

    UserProfile updatedProfile = UserProfile(
      firstName: firstName,
      lastName: lastName,
      title: title,
      aboutMe: aboutMe,
      skills: skills,
    );

    await _firestoreDatabase.updateProfile(updatedProfile);
  }
}
