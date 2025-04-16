class PostModel {
  final String id;
  final String userId;
  final String? text;
  final String? audioUrl;
  final DateTime createdAt;
  final String? postType;
  final int? durationHours;
  final int? responses;
  final int? likes;

  // User Info that should come from `All Users`
  final String? userName;
  final String? userProfilePic;
  final double? rating;  // Rating can be null
  final int? reviews;    // Number of reviews

  PostModel({
    required this.id,
    required this.userId,
    this.text,
    this.audioUrl,
    required this.createdAt,
    this.postType,
    this.durationHours,
    this.responses,
    this.likes,
    this.userName,
    this.userProfilePic,
    this.rating,
    this.reviews,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userProfilePic': userProfilePic,
      'text': text,
      'audioUrl': audioUrl,
      'createdAt': createdAt.toIso8601String(),
      if (postType != null) 'postType': postType,
      if (durationHours != null) 'durationHours': durationHours,
      if (responses != null) 'responses': responses,
      if (likes != null) 'likes': likes,
      if (rating != null) 'rating': rating,
      if (reviews != null) 'reviews': reviews,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      userId: map['userId'],
      userName: map['userName'],
      userProfilePic: map['userProfilePic'],
      text: map['text'],
      audioUrl: map['audioUrl'],
      createdAt: DateTime.parse(map['createdAt']),
      postType: map['postType'],
      durationHours: map['durationHours'],
      responses: map['responses'],
      likes: map['likes'],
      rating: map['rating']?.toDouble(),
      reviews: map['reviews'],
    );
  }
}


// class PostModel {
//   final String id;
//   final String userId;
//   final String? userName;        // ✅ optional
//   final String? userProfilePic;  // ✅ optional
//   final String? text;
//   final String? audioUrl;
//   final DateTime createdAt;

//   // Optional metadata
//   final String? postType;
//   final int? durationHours;
//   final int? responses;
//   final int? likes;

//   PostModel({
//     required this.id,
//     required this.userId,
//     this.userName,
//     this.userProfilePic,
//     this.text,
//     this.audioUrl,
//     required this.createdAt,
//     this.postType,
//     this.durationHours,
//     this.responses,
//     this.likes,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userId': userId,
//       'userName': userName,
//       'userProfilePic': userProfilePic,
//       'text': text,
//       'audioUrl': audioUrl,
//       'createdAt': createdAt.toIso8601String(),
//       if (postType != null) 'postType': postType,
//       if (durationHours != null) 'durationHours': durationHours,
//       if (responses != null) 'responses': responses,
//       if (likes != null) 'likes': likes,
//     };
//   }

//   factory PostModel.fromMap(Map<String, dynamic> map) {
//     return PostModel(
//       id: map['id'],
//       userId: map['userId'],
//       userName: map['userName'], // might be null
//       userProfilePic: map['userProfilePic'], // might be null
//       text: map['text'],
//       audioUrl: map['audioUrl'],
//       createdAt: DateTime.parse(map['createdAt']),
//       postType: map['postType'],
//       durationHours: map['durationHours'],
//       responses: map['responses'],
//       likes: map['likes'],
//     );
//   }
// }
