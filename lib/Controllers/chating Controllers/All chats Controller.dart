// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class MessageListController extends GetxController {
//   var users = <Map<String, dynamic>>[].obs;  // Store all users here
  
//   // Fetch all users from Firestore
//   void fetchAllUsers() {
//     FirebaseFirestore.instance.collection('All Users').snapshots().listen((snapshot) {
//       users.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//     });
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageListController extends GetxController {
  var users = <Map<String, dynamic>>[].obs;

  // Fetch all users that the current user has conversations with
  void fetchChatUsers(String currentUser) {
    FirebaseFirestore.instance.collection('chats').snapshots().listen((snapshot) {
      final usersSet = <String>{};
      
      // Iterate over the chats and filter by current user
      for (var doc in snapshot.docs) {
        if (doc.id.contains(currentUser)) {
          final parts = doc.id.split('_');
          final otherUser = parts[0] == currentUser ? parts[1] : parts[0];
          usersSet.add(otherUser);  // Add the other user to the list
        }
      }
      
      // Fetch users' details from the `users` collection
      users.value = usersSet.map((userId) {
        return FirebaseFirestore.instance
            .collection('All Users')
            .doc(userId)
            .get()
            .then((doc) => doc.data() as Map<String, dynamic>);
      }).cast<Map<String, dynamic>>().toList();
    });
  }
}
