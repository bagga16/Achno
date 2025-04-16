
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
    return user != null ? PostCard(post: post, user: user) : const SizedBox.shrink();
  },
);

        // return ListView.builder(
        //   itemCount: controller.posts.length,
        //   itemBuilder: (_, i) {
        //     final post = controller.posts[i];
        //     final user = controller.users[post.userId];
        //     return user != null
        //         ? PostCard(post: post, user: user)
        //         : const SizedBox.shrink();
        //   },
        // );
      }),
    );
  }
}
