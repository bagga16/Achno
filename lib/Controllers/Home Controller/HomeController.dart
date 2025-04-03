// // controllers/home_controller.dart

// import 'package:achno/Models/Post%20Model.dart';
// import 'package:get/get.dart';

// class HomeController extends GetxController {
//   // Reactive variable to hold posts
//   var posts = <PostModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchPosts(); // Fetch posts when the controller is initialized
//   }

//   void fetchPosts() {
//     posts.value = [
//       PostModel(
//         username: 'Ahmed Benali',
//         userType: 'Plumber',
//         postTitle: 'Urgent plumbing repair needed',
//         postDescription: 'Plumbing issue needs urgent attention. Please help.',
//         distance: '1.2 km away',
//         timeLeft: 'Expires in 2 days',
//         profileImage: 'assets/images/bagga.jpg',
//         rating: 4.5,
//         responses: 24,
//         postType: 'Respond',
//       ),
//       PostModel(
//         username: 'Sophia Elmahdi',
//         userType: 'Service/Product',
//         postTitle: 'Math and Physics Tutoring for High School Students',
//         postDescription: 'Offering tutoring sessions for math and physics. Flexible hours.',
//         distance: '3.5 km away',
//         timeLeft: '7 days remaining',
//         profileImage: 'assets/images/bagga.jpg',
//         rating: 5.0,
//         responses: 18,
//         postType: 'Respond',
//       ),
//     ];
//   }
// }


// controllers/home_controller.dart

import 'package:achno/Models/Post%20Model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Reactive variable to hold posts
  var posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts(); // Fetch posts when the controller is initialized
  }

  void fetchPosts() {
    posts.value = [
      PostModel(
        username: 'Ahmed Benali',
        userType: 'Plumber',
        postTitle: 'Urgent plumbing repair needed',
        postDescription: 'Plumbing issue needs urgent attention. Please help.',
        distance: '1.2 km away',
        timeLeft: 'Expires in 2 days',
        profileImage: 'assets/images/logo.png',
        rating: 4.5,
        responses: 24,
        postType: 'Request',
        isVoiceMessage: true,
        duration: '0:24',
      ),
      PostModel(
        username: 'Sophia Elmahdi',
        userType: 'Service/Product',
        postTitle: 'Math and Physics Tutoring for High School Students',
        postDescription: 'Offering tutoring sessions for math and physics. Flexible hours.',
        distance: '3.5 km away',
        timeLeft: '7 days remaining',
        profileImage: 'assets/images/logo.png',
        rating: 5.0,
        responses: 18,
        postType: 'Service',
        isVoiceMessage: false,
        duration: '',
      ),
    ];
  }
}
