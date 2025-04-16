

// import 'package:achno/App%20Widgets/PostCard.dart';
// import 'package:achno/Controllers/Home%20Controller/Post%20Controller.dart';
// import 'package:achno/Models/Post%20Model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class HomeScreen extends StatelessWidget {
//   final PostController postController = Get.put(PostController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: FutureBuilder<List<PostModel>>(
//         future: postController.fetchPosts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No posts available'));
//           }
//           var posts = snapshot.data!;
//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               return PostCard(post: posts[index]);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:achno/App%20Widgets/PostCard.dart';
import 'package:achno/Controllers/Home%20Controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        title: const Text("Hello Ahmad"),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () {})
        ],
      ),
      body: Obx(() {
        if (controller.posts.isEmpty || controller.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (_, i) {
            final post = controller.posts[i];
            final user = controller.users[post.userId];
            return user != null
                ? PostCard(post: post, user: user)
                : const SizedBox.shrink();
          },
        );
      }),
    );
  }
}
