

// class Post {
//   String id;
//   String userId;
//   String postContent;
//   bool isVoicePost;
//   String mediaUrl;
//   String serviceType;
//   String username;
//   String userType;
//   String profileImage;
//   String timestamp;
//   String distance;
//   String timeLeft;
//   double? rating;
//   int responses;
//   String postType; // Add postType to indicate if it's a request or service post

//   Post({
//     required this.id,
//     required this.userId,
//     required this.postContent,
//     required this.isVoicePost,
//     required this.mediaUrl,
//     required this.serviceType,
//     required this.username,
//     required this.userType,
//     required this.profileImage,
//     required this.timestamp,
//     required this.distance,
//     required this.timeLeft,
//     this.rating,
//     required this.responses,
//     required this.postType, // Initialize postType here
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'postContent': postContent,
//       'isVoicePost': isVoicePost,
//       'mediaUrl': mediaUrl,
//       'serviceType': serviceType,
//       'username': username,
//       'userType': userType,
//       'profileImage': profileImage,
//       'timestamp': timestamp,
//       'distance': distance,
//       'timeLeft': timeLeft,
//       'rating': rating,
//       'responses': responses,
//       'postType': postType, // Include postType here
//     };
//   }

//   factory Post.fromMap(Map<String, dynamic> map, String postId) {
//     return Post(
//       id: postId,
//       userId: map['userId'],
//       postContent: map['postContent'],
//       isVoicePost: map['isVoicePost'],
//       mediaUrl: map['mediaUrl'],
//       serviceType: map['serviceType'],
//       username: map['username'],
//       userType: map['userType'],
//       profileImage: map['profileImage'],
//       timestamp: map['timestamp'],
//       distance: map['distance'],
//       timeLeft: map['timeLeft'],
//       rating: map['rating']?.toDouble(),
//       responses: map['responses'] ?? 0,
//       postType: map['postType'] ?? 'Request', // Ensure postType is not null
//     );
//   }
// }

// models/post_model.dart
class PostModel {
  final String id;
  final String userId;
  final String userName;
  final String userProfilePic;
  final String? text;
  final String? audioUrl;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfilePic,
    this.text,
    this.audioUrl,
    required this.createdAt,
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
    );
  }
}
