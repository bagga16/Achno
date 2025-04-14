

import 'package:achno/App%20Widgets/PostCard.dart';
import 'package:achno/Controllers/Home%20Controller/Post%20Controller.dart';
import 'package:achno/Models/Post%20Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomeScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder<List<PostModel>>(
        future: postController.fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
          }
          var posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostCard(post: posts[index]);
            },
          );
        },
      ),
    );
  }
}
