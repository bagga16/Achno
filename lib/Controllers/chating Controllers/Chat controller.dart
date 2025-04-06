// // import 'dart:io';
//  import 'package:achno/Models/MessageModel.dart';


// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';

// class ChatController extends GetxController {
//   var messages = <MessageModel>[].obs;
//    var users = <Map<String, dynamic>>[].obs;  // Store all users here
  
  

//   String chatId(String user1, String user2) =>
//       user1.hashCode <= user2.hashCode ? '${user1}_$user2' : '${user2}_$user1';
// // Fetch all users from Firestore
//   void fetchAllUsers() {
//     FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
//       users.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//     });
//   }
//   // Listen for messages from Firestore in real-time
//   void listenToMessages(String currentUser, String otherUser) {
//     final id = chatId(currentUser, otherUser);
//     FirebaseFirestore.instance
//         .collection('chats')
//         .doc(id)
//         .collection('messages')
//         .orderBy('timestamp')
//         .snapshots()
//         .listen((query) {
//       messages.value = query.docs
//           .map((doc) => MessageModel.fromJson(doc.data()))
//           .toList();
//     });
//   }

//   // Send text message
//   Future<void> sendTextMessage(String currentUser, String otherUser, String content) async {
//     final id = chatId(currentUser, otherUser);
//     final message = MessageModel(
//       sender: currentUser,
//       message: content,
//       timestamp: DateTime.now().toIso8601String(),
//       isVoiceMessage: false,
//       duration: '',
//     );
//     await FirebaseFirestore.instance
//         .collection('chats')
//         .doc(id)
//         .collection('messages')
//         .add(message.toJson());
//   }

//   // Send voice message
//   Future<void> sendVoiceMessage(String currentUser, String otherUser, File file, String duration) async {
//     final id = chatId(currentUser, otherUser);
//     final fileName = '${DateTime.now().millisecondsSinceEpoch}.aac';
//     final ref = FirebaseStorage.instance.ref().child('voice_messages/$fileName');
//     final uploadTask = await ref.putFile(file);
//     final url = await uploadTask.ref.getDownloadURL();

//     final message = MessageModel(
//       sender: currentUser,
//       message: url,
//       timestamp: DateTime.now().toIso8601String(),
//       isVoiceMessage: true,
//       duration: duration,
//     );

//     await FirebaseFirestore.instance
//         .collection('chats')
//         .doc(id)
//         .collection('messages')
//         .add(message.toJson());
//   }
// }

import 'dart:io';
import 'package:achno/Models/MessageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
class ChatController extends GetxController {
  var messages = <MessageModel>[].obs;

  // Generate unique chat ID between two users
  String chatId(String user1, String user2) {
    return user1.hashCode <= user2.hashCode ? '${user1}_$user2' : '${user2}_$user1';
  }

  // Listen for messages from Firestore in real-time between current user and the other user
  void listenToMessages(String currentUser, String otherUser) {
    final id = chatId(currentUser, otherUser); // Generate the chat ID based on the users
    FirebaseFirestore.instance
        .collection('chats')
        .doc(id) // Access the specific chat document
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((query) {
      messages.value = query.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .where((msg) => msg.sender == currentUser || msg.sender == otherUser) // Filter messages
          .toList();
    });
  }

  // Send text message
  Future<void> sendTextMessage(String currentUser, String otherUser, String content) async {
    final id = chatId(currentUser, otherUser); // Get chat ID for the conversation
    final message = MessageModel(
      sender: currentUser,
      message: content,
      timestamp: DateTime.now().toIso8601String(),
      isVoiceMessage: false,
      duration: '',
    );
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(id)
        .collection('messages')
        .add(message.toJson());
  }

  // Send voice message
  Future<void> sendVoiceMessage(String currentUser, String otherUser, File file, String duration) async {
    final id = chatId(currentUser, otherUser); // Get chat ID for the conversation
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.aac';
    final ref = FirebaseStorage.instance.ref().child('voice_messages/$fileName');
    final uploadTask = await ref.putFile(file);
    final url = await uploadTask.ref.getDownloadURL();

    final message = MessageModel(
      sender: currentUser,
      message: url,
      timestamp: DateTime.now().toIso8601String(),
      isVoiceMessage: true,
      duration: duration,
    );

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(id)
        .collection('messages')
        .add(message.toJson());
  }
}
