// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../../Models/MessageModel.dart';

// class MessageController extends GetxController {
//   var messages = <MessageModel>[].obs;

//   String chatId(String user1, String user2) =>
//       user1.hashCode <= user2.hashCode
//           ? '${user1}_$user2'
//           : '${user2}_$user1';

//   void listenToMessages(String currentUser, String otherUser) {
//     final id = chatId(currentUser, otherUser);
//     FirebaseFirestore.instance
//         .collection('chats')
//         .doc(id)
//         .collection('messages')
//         .orderBy('timestamp')
//         .snapshots()
//         .listen((querySnapshot) {
//           messages.value = querySnapshot.docs
//               .map((doc) => MessageModel.fromJson(doc.data()))
//               .toList();
//         });
//   }

//   Future<void> sendMessage(String currentUser, String otherUser, MessageModel message) async {
//     final id = chatId(currentUser, otherUser);
//     await FirebaseFirestore.instance
//         .collection('chats')
//         .doc(id)
//         .collection('messages')
//         .add(message.toJson());
//   }
// }
