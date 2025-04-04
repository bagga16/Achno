import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageListController extends GetxController {
  var chatUsers = <String>[].obs;

  // Fetch the list of users the current user has chatted with
  void fetchChatUsers(String currentUser) {
    FirebaseFirestore.instance.collection('chats').snapshots().listen((snapshot) {
      final users = <String>{};
      for (var doc in snapshot.docs) {
        final id = doc.id;
        if (id.contains(currentUser)) {
          final parts = id.split('_');
          final otherUser = parts[0] == currentUser ? parts[1] : parts[0];
          users.add(otherUser);
        }
      }
      chatUsers.value = users.toList();
    });
  }
}
