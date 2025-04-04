// // controllers/post_controller.dart

// import 'package:achno/Models/Post%20Model.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:intl/intl.dart';

// class PostController extends GetxController {
//   // Reactive variables to hold post data
//   var isLoading = false.obs;
//   var postContent = ''.obs;
//   var serviceType = 'Plumber'.obs; // Default service type
//   var ratings = Rxn<double>(); // This will hold the rating (optional)

//   // Method to create a post
//   Future<void> createPost(bool isVoicePost, {XFile? audioFile}) async {
//     try {
//       isLoading.value = true;

//       // Get current timestamp
//       String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

//       // If it's a voice post, upload the audio to Firebase Storage
//       String mediaUrl = '';
//       if (isVoicePost && audioFile != null) {
//         mediaUrl = await _uploadVoicePost(audioFile);
//       }

//       // Create Post object
//       Post post = Post(
//         id: '',
//         userId: 'userId',  // This should be the current user's ID from Firebase Auth
//         postContent: postContent.value,
//         isVoicePost: isVoicePost,
//         mediaUrl: mediaUrl,
//         serviceType: serviceType.value,
//         timestamp: timestamp,
//         ratings: ratings.value, // Add ratings if provided
//       );

//       // Save to Firestore
//       DocumentReference postRef = await FirebaseFirestore.instance.collection('AllPosts').add(post.toMap());
//       post.id = postRef.id;

//       isLoading.value = false;
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar('Error', 'Failed to create post: $e');
//     }
//   }

//   // Method to upload audio file to Firebase Storage and return URL
//   Future<String> _uploadVoicePost(XFile audioFile) async {
//     try {
//       String fileName = audioFile.name;
//       Reference storageRef = FirebaseStorage.instance.ref().child('voice_posts/$fileName');
//       UploadTask uploadTask = storageRef.putFile(File(audioFile.path));
//       TaskSnapshot snapshot = await uploadTask;
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       throw 'Failed to upload voice post: $e';
//     }
//   }

//  Future<List<Post>> fetchPosts() async {
//     try {
//       // Ensure Firestore is initialized
//       FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);  // Enable persistence if required

//       QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('AllPosts').get();
//       return snapshot.docs.map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
//     } catch (e) {
//       print("Failed to fetch posts: $e");
//       throw 'Failed to fetch posts: $e';
//     }
//   }
// }


// controllers/post_controller.dart

import 'package:achno/Models/Post%20Model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class PostController extends GetxController {
  var isLoading = false.obs;
  var postContent = ''.obs;
  var serviceType = 'Plumber'.obs;
  var postType = 'Request'.obs; // Default postType
  var username = 'John Doe'.obs;
  var userType = 'Service Provider'.obs;
  var profileImage = 'https://via.placeholder.com/150'.obs;
  var city = 'Lahore'.obs; // Default city
  var postDuration = '48 Hours'.obs; // Default post duration
  var distance = '3.2 km away'.obs;
  var timeLeft = '48 Hours remaining'.obs;
  var rating = Rxn<double>();
  var responses = 5.obs;

  // Method to create a post
  Future<void> createPost(bool isVoicePost, {XFile? audioFile}) async {
    try {
      isLoading.value = true;

      String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      String mediaUrl = '';

      if (isVoicePost && audioFile != null) {
        mediaUrl = await _uploadVoicePost(audioFile);
      }

      Post post = Post(
        id: '',
        userId: 'userId', // This should be the current user's ID from Firebase Auth
        postContent: postContent.value,
        isVoicePost: isVoicePost,
        mediaUrl: mediaUrl,
        serviceType: serviceType.value,
        username: username.value,
        userType: userType.value,
        profileImage: profileImage.value,
        timestamp: timestamp,
        distance: distance.value,
        timeLeft: timeLeft.value,
        rating: rating.value,
        responses: responses.value,
        postType: postType.value, // Ensure postType is correctly set
      );

      // Save to Firestore
      DocumentReference postRef = await FirebaseFirestore.instance.collection('AllPosts').add(post.toMap());
      post.id = postRef.id;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to create post: $e');
    }
  }

  Future<String> _uploadVoicePost(XFile audioFile) async {
    try {
      String fileName = audioFile.name;
      Reference storageRef = FirebaseStorage.instance.ref().child('voice_posts/$fileName');
      UploadTask uploadTask = storageRef.putFile(File(audioFile.path));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw 'Failed to upload voice post: $e';
    }
  }
   Future<List<Post>> fetchPosts() async {
    try {
      // Ensure Firestore is initialized
      FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);  // Enable persistence if required

      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('AllPosts').get();
      return snapshot.docs.map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      print("Failed to fetch posts: $e");
      throw 'Failed to fetch posts: $e';
    }
  }
}
