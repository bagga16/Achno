

// import 'package:achno/Models/Post%20Model.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:intl/intl.dart';

// class PostController extends GetxController {
//   var isLoading = false.obs;
//   var postContent = ''.obs;
//   var serviceType = 'Plumber'.obs;
//   var postType = 'Request'.obs; // Default postType
//   var username = 'John Doe'.obs;
//   var userType = 'Service Provider'.obs;
//   var profileImage = 'https://via.placeholder.com/150'.obs;
//   var city = 'Lahore'.obs; // Default city
//   var postDuration = '48 Hours'.obs; // Default post duration
//   var distance = '3.2 km away'.obs;
//   var timeLeft = '48 Hours remaining'.obs;
//   var rating = Rxn<double>();
//   var responses = 5.obs;

//   // Method to create a post
//   Future<void> createPost(bool isVoicePost, {XFile? audioFile}) async {
//     try {
//       isLoading.value = true;

//       String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//       String mediaUrl = '';

//       if (isVoicePost && audioFile != null) {
//         mediaUrl = await _uploadVoicePost(audioFile);
//       }

//       Post post = Post(
//         id: '',
//         userId: 'userId', // This should be the current user's ID from Firebase Auth
//         postContent: postContent.value,
//         isVoicePost: isVoicePost,
//         mediaUrl: mediaUrl,
//         serviceType: serviceType.value,
//         username: username.value,
//         userType: userType.value,
//         profileImage: profileImage.value,
//         timestamp: timestamp,
//         distance: distance.value,
//         timeLeft: timeLeft.value,
//         rating: rating.value,
//         responses: responses.value,
//         postType: postType.value, // Ensure postType is correctly set
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
  //   try {
  //     // Ensure Firestore is initialized
  //     FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);  // Enable persistence if required

  //     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('AllPosts').get();
  //     return snapshot.docs.map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
  //   } catch (e) {
  //     print("Failed to fetch posts: $e");
  //     throw 'Failed to fetch posts: $e';
  //   }
  // }
// }

import 'dart:io';
import 'package:achno/Models/Post%20Model.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostController extends GetxController {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  final RxBool isRecording = false.obs;
  final RxBool isPlaying = false.obs;
  final RxString audioPath = ''.obs;

  @override
  void onInit() {
    _recorder.openRecorder();
    _player.openPlayer();
    super.onInit();
  }

  Future<void> startRecording() async {
    final mic = await Permission.microphone.request();
    if (!mic.isGranted) {
      Get.snackbar('Permission', 'Microphone permission denied');
      return;
    }

    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/voice_post.aac';
    await _recorder.startRecorder(toFile: path, codec: Codec.aacADTS);

    audioPath.value = path;
    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
    isRecording.value = false;
  }

  Future<void> playRecording() async {
    if (audioPath.value.isEmpty) return;
    await _player.startPlayer(
      fromURI: audioPath.value,
      whenFinished: () => isPlaying.value = false,
    );
    isPlaying.value = true;
  }

  Future<void> stopPlayback() async {
    await _player.stopPlayer();
    isPlaying.value = false;
  }

  Future<String?> uploadAudio(String path) async {
    final file = File(path);
    final ref = FirebaseStorage.instance
        .ref('posts/audio_${DateTime.now().millisecondsSinceEpoch}.aac');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
Future<void> createPost({
  required String text,
  required String city,
  required String profession,
  required String duration,
  required List<XFile> images,
}) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  List<String> imageUrls = [];
  for (var img in images) {
    final ref = FirebaseStorage.instance
        .ref('posts/images/${DateTime.now().millisecondsSinceEpoch}_${img.name}');
    await ref.putFile(File(img.path));
    final url = await ref.getDownloadURL();
    imageUrls.add(url);
  }

  String? audioUrl;
  if (audioPath.value.isNotEmpty) {
    audioUrl = await uploadAudio(audioPath.value);
  }

  final id = FirebaseFirestore.instance.collection('posts').doc().id;
  final post = {
    'id': id,
    'userId': uid,
    'text': text,
    'audioUrl': audioUrl,
    'city': city,
    'profession': profession,
    'duration': duration,
    'imageUrls': imageUrls,
    'createdAt': DateTime.now().toIso8601String(),
  };

  await FirebaseFirestore.instance.collection('posts').doc(id).set(post);
}


  Future<List<PostModel>> fetchPosts() async {
    try {
      // Ensure Firestore is initialized
      FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);  // Enable persistence if required

      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('AllPosts').get();
      return snapshot.docs.map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>, )).toList();
    } catch (e) {
      print("Failed to fetch posts: $e");
      throw 'Failed to fetch posts: $e';
    }
  }
}
