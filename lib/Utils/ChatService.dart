import 'package:achno/Models/MessageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
       // .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList());
  }

  Future<void> sendMessage(String chatId, MessageModel message) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());

    // Update last message in chat document
    await _firestore.collection('chats').doc(chatId).set({
      'lastMessage': message.text ?? 'Voice Message',
      'timestamp': message.timestamp.toIso8601String(),
      'participants': [message.senderId, message.receiverId],
    }, SetOptions(merge: true));
  }
}
