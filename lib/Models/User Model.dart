class UserModel {
  final String uid;
  final String phone;
  final String city;
  final String activity;
  final String location;
  final String profileImage;

  UserModel({
    required this.uid,
    required this.phone,
    required this.city,
    required this.activity,
    required this.location,
    required this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'city': city,
      'activity': activity,
      'location': location,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      phone: map['phone'],
      city: map['city'],
      activity: map['activity'],
      location: map['location'],
      profileImage: map['profileImage'],
    );
  }
}
