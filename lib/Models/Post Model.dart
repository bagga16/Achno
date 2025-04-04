// // models/post_model.dart

// class PostModel {
//   final String username;
//   final String userType;
//   final String postTitle;
//   final String postDescription;
//   final String distance;
//   final String timeLeft;
//   final String profileImage;
//   final double rating;
//   final int responses;
//   final String postType;
//    bool isVoiceMessage;
//   final String duration;

//   PostModel({
//     required this.username,
//     required this.userType,
//     required this.postTitle,
//     required this.postDescription,
//     required this.distance,
//     required this.timeLeft,
//     required this.profileImage,
//     required this.rating,
//     required this.responses,
//     required this.postType,
//      this.isVoiceMessage = false,
//     required this.duration,
//   });
// }

// models/post_model.dart

class Post {
  String id;
  String userId;
  String postContent;
  bool isVoicePost;
  String mediaUrl;
  String serviceType;
  String username;
  String userType;
  String profileImage;
  String timestamp;
  String distance;
  String timeLeft;
  double? rating;
  int responses;
  String postType; // Add postType to indicate if it's a request or service post

  Post({
    required this.id,
    required this.userId,
    required this.postContent,
    required this.isVoicePost,
    required this.mediaUrl,
    required this.serviceType,
    required this.username,
    required this.userType,
    required this.profileImage,
    required this.timestamp,
    required this.distance,
    required this.timeLeft,
    this.rating,
    required this.responses,
    required this.postType, // Initialize postType here
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'postContent': postContent,
      'isVoicePost': isVoicePost,
      'mediaUrl': mediaUrl,
      'serviceType': serviceType,
      'username': username,
      'userType': userType,
      'profileImage': profileImage,
      'timestamp': timestamp,
      'distance': distance,
      'timeLeft': timeLeft,
      'rating': rating,
      'responses': responses,
      'postType': postType, // Include postType here
    };
  }

  factory Post.fromMap(Map<String, dynamic> map, String postId) {
    return Post(
      id: postId,
      userId: map['userId'],
      postContent: map['postContent'],
      isVoicePost: map['isVoicePost'],
      mediaUrl: map['mediaUrl'],
      serviceType: map['serviceType'],
      username: map['username'],
      userType: map['userType'],
      profileImage: map['profileImage'],
      timestamp: map['timestamp'],
      distance: map['distance'],
      timeLeft: map['timeLeft'],
      rating: map['rating']?.toDouble(),
      responses: map['responses'] ?? 0,
      postType: map['postType'] ?? 'Request', // Ensure postType is not null
    );
  }
}
