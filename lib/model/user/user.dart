class UserModel {
  String uid; // Unique identifier for the user
  String name;
  String email;
  String password;
  String profileImage;
  UserMetadata? userMetadata;
  String? createdAt;

  UserModel(
      {required this.uid, // Ensure uid is required
      required this.name,
      required this.email,
      required this.password,
      required this.profileImage,
      this.userMetadata,
      this.createdAt});

  // Convert User to Map (for Firebase Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid, // Include uid in the map
      'name': name,
      'email': email,
      'password': password, // Consider encrypting the password before saving
      'profilePicture': profileImage,
      'createdAt': createdAt, // Consider encrypting the password before saving
      'metaDataAdded': userMetadata?.toMap(), // Include user metadata as a map
    };
  }

  // Convert Map to User
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '', // Ensure uid is populated
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '', // Ensure secure handling of passwords
      profileImage: map['profilePicture'] ?? '', // Ensure secure handling of passwords
      createdAt: map['createdAt'] ?? DateTime.now(),
      userMetadata: map['metaDataAdded'] != null ? UserMetadata.fromMap(map['metaData']) : null,
    );
  }
}

class UserMetadata {
  String language;
  int level;
  String reason;
  String interest;
  String occupation;
  String country;
  int age;
  double height;
  String gender;
  String relationshipStatus;

  UserMetadata({
    required this.language,
    required this.level,
    required this.reason,
    required this.interest,
    required this.occupation,
    required this.country,
    required this.age,
    required this.height,
    required this.gender,
    required this.relationshipStatus,
  });

  // Convert UserMetadata to Map (for Firebase Firestore)
  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'level': level,
      'reason': reason,
      'interest': interest,
      'occupation': occupation,
      'country': country,
      'age': age,
      'height': height,
      'gender': gender,
      'relationshipStatus': relationshipStatus,
    };
  }

  // Convert Map to UserMetadata
  factory UserMetadata.fromMap(Map<String, dynamic> map) {
    return UserMetadata(
      language: map['language'] ?? '',
      level: map['level'] ?? 0,
      reason: map['reason'] ?? '',
      interest: map['interest'] ?? '',
      occupation: map['occupation'] ?? '',
      country: map['country'] ?? '',
      age: map['age'] ?? 0,
      height: map['height']?.toDouble() ?? 0.0, // Convert to double if needed
      gender: map['gender'] ?? '',
      relationshipStatus: map['relationshipStatus'] ?? '',
    );
  }
}
