class UserProfile {
  String firstName;
  String lastName;
  String title;
  String aboutMe;
  List<String> skills;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.aboutMe,
    required this.skills,
  });

  // Convert a UserProfile into a Map. The keys must correspond to the names of the fields in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'title': title,
      'aboutMe': aboutMe,
      'skills': skills,
    };
  }

  // Create a UserProfile from a Map. This is helpful when retrieving data from Firestore.
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      firstName: map['firstName'],
      lastName: map['lastName'],
      title: map['title'],
      aboutMe: map['aboutMe'],
      skills: List<String>.from(map['skills']),
    );
  }
}
