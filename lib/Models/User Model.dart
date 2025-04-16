// class UserModel {
//   final String uid;
//   final String phone;
//   final String fullName;
//   final String city;
//   final String activity;
//   final String textInfo;
//   final String videoIntro;

//   final String location;
//   final String profileImage;

//   UserModel({
//     required this.uid,
//     required this.phone,
//     required this.city,
//     required this.activity,
//         required this.textInfo,
//     required this.location,
//      required this.fullName,
//        required this.videoIntro,
//     required this.profileImage,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'phone': phone,
//        'fullName': fullName,
//       'city': city,
//       'activity': activity,
//       'textInfo': textInfo,
//       'videoIntro': videoIntro,
//       'location': location,
//       'profileImage': profileImage,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       uid: map['uid'],
//       phone: map['phone'],
//    fullName: map['fullName'] ?? '',
//       city: map['city'] ?? '',
//       activity: map['activity'] ?? '',
//       textInfo: map['textInfo'] ?? '',
//       videoIntro: map['videoIntro'] ?? '',
//       location: map['location'],
//       profileImage: map['profileImage'],
//     );
//   }
// }


class UserModel {
  final String uid;
  final String phone;
  final String fullName;
  final String city;
  final String activity;
  final String textInfo;
  final String videoIntro;
  final String location;
  final String profileImage;

  // 🔥 Optional fields (safe additions)
  final double? rating;
  final int? reviews;

  UserModel({
    required this.uid,
    required this.phone,
    required this.city,
    required this.activity,
    required this.textInfo,
    required this.location,
    required this.fullName,
    required this.videoIntro,
    required this.profileImage,
    this.rating,
    this.reviews,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'fullName': fullName,
      'city': city,
      'activity': activity,
      'textInfo': textInfo,
      'videoIntro': videoIntro,
      'location': location,
      'profileImage': profileImage,
      if (rating != null) 'rating': rating,
      if (reviews != null) 'reviews': reviews,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      phone: map['phone'],
      fullName: map['fullName'] ?? '',
      city: map['city'] ?? '',
      activity: map['activity'] ?? '',
      textInfo: map['textInfo'] ?? '',
      videoIntro: map['videoIntro'] ?? '',
      location: map['location'] ?? '',
      profileImage: map['profileImage'] ?? '',
      rating: map['rating']?.toDouble(),
      reviews: map['reviews'],
    );
  }
}
