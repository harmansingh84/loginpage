import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/classes/user_class.dart';

class FirestoreDatabase {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference profileCollection = FirebaseFirestore.instance.collection("Profile");

  Future<void> createProfile(UserProfile currentUserProfile) {
    return profileCollection.doc(user?.uid).set(currentUserProfile.toMap());
  }
  Future<void> updateProfile(UserProfile updatedUserProfile){
    return profileCollection.doc(user?.uid).update(updatedUserProfile.toMap());
  }
  Stream<DocumentSnapshot> getProfileInfo() {
    return profileCollection.doc(user?.uid).snapshots();
  }
}
