// import 'package:achno/Models/Post%20Model.dart';
// import 'package:achno/Models/User%20Model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class HomeController extends GetxController {
//   final posts = <PostModel>[].obs;
//   final users = <String, UserModel>{}.obs;

//   @override
//   void onInit() {
//     fetchPosts();
//     super.onInit();
//   }
// Future<void> fetchPosts() async {
//   try {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('posts')
//         .orderBy('createdAt', descending: true)
//         .get();

//     if (snapshot.docs.isEmpty) {
//       print("❌ No posts found");
//     }

//     final postList = snapshot.docs.map((doc) {
//       print("✅ Post loaded: ${doc.data()}");
//       return PostModel.fromMap(doc.data());
//     }).toList();

//     final userIds = postList.map((p) => p.userId).toSet();
//     for (var uid in userIds) {
//       final userDoc = await FirebaseFirestore.instance.collection('All Users').doc(uid).get();
//       if (userDoc.exists) {
//         users[uid] = UserModel.fromMap(userDoc.data()!);
//       } else {
//         print("❌ User not found for post: $uid");
//       }
//     }

//     posts.assignAll(postList);
//     print("✅ Posts loaded: ${posts.length}");
//   } catch (e) {
//     print("❌ Error loading posts: $e");
//   }
// }
// }
import 'package:achno/Models/Post%20Model.dart';
import 'package:achno/Models/User%20Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final posts = <PostModel>[].obs;
  final users = <String, UserModel>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts(); // Fetch posts when screen initializes
  }

  Future<void> fetchPosts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('posts') // Ensure collection name is correct
          .orderBy('createdAt', descending: true)
          .get();

      if (snapshot.docs.isEmpty) {
        print("❌ No posts found");
      }

      final postList = snapshot.docs.map((doc) {
        print("✅ Post loaded: ${doc.data()}");
        return PostModel.fromMap(doc.data());
      }).toList();

      // Fetch user data based on userId
      final userIds = postList.map((p) => p.userId).toSet();
      for (var uid in userIds) {
        final userDoc = await FirebaseFirestore.instance.collection('All Users').doc(uid).get();
        if (userDoc.exists) {
          users[uid] = UserModel.fromMap(userDoc.data()!);
        } else {
          print("❌ User not found for post: $uid");
        }
      }

      posts.assignAll(postList);
      print("✅ Posts loaded: ${posts.length}");
    } catch (e) {
      print("❌ Error loading posts: $e");
    }
  }
}
