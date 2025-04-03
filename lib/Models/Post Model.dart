// models/post_model.dart

class PostModel {
  final String username;
  final String userType;
  final String postTitle;
  final String postDescription;
  final String distance;
  final String timeLeft;
  final String profileImage;
  final double rating;
  final int responses;
  final String postType;
   bool isVoiceMessage;
  final String duration;

  PostModel({
    required this.username,
    required this.userType,
    required this.postTitle,
    required this.postDescription,
    required this.distance,
    required this.timeLeft,
    required this.profileImage,
    required this.rating,
    required this.responses,
    required this.postType,
     this.isVoiceMessage = false,
    required this.duration,
  });
}
