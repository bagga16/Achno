// // screens/home_screen.dart

// import 'package:achno/App%20Widgets/PostCard.dart';
// import 'package:achno/Controllers/Home%20Controller/PostController.dart';
// import 'package:achno/Utils/Localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final HomeController homeController = Get.put(HomeController());

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalizations.of(context)!.home), // Dynamic text based on language
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Obx(
//         () => ListView.builder(
//           itemCount: homeController.posts.length,
//           itemBuilder: (context, index) {
//             return PostCard(post: homeController.posts[index]);
//           },
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.blue,
//         selectedItemColor: Colors.amber,
//         unselectedItemColor: Colors.blueGrey,
//         items: [
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.home),
//             label: AppLocalizations.of(context)!.home, 
//           ),
//          BottomNavigationBarItem(
//             icon: const Icon(Icons.message),
//             label: AppLocalizations.of(context)!.messages,
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.notifications),
//             label: AppLocalizations.of(context)!.profile,
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.account_circle),
//             label: AppLocalizations.of(context)!.profile,
//           ),
//         ],
//       ),
//     );
//   }
// }

// screens/home_screen.dart
// screens/home_screen.dart

import 'package:achno/App%20Screens/Home%20Screens/Messages.dart';
import 'package:achno/App%20Screens/Home%20Screens/Notifications.dart';
import 'package:achno/App%20Widgets/PostCard.dart';
import 'package:achno/Controllers/Home%20Controller/PostController.dart';
import 'package:achno/Utils/Localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home), // Dynamic text based on language
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Get.to(() => Notifications());  // Navigate to notifications screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {} // Add settings screen logic if needed
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: homeController.posts.length,
          itemBuilder: (context, index) {
            return PostCard(post: homeController.posts[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home, 
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.message),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
        onTap: (index) {
          // Handle navigation based on the tapped index
          switch (index) {
            case 1:
              Get.to(() => Messages());  // Navigate to Messages screen
              break;
            case 2:
              Get.to(() => Notifications());  // Navigate to Notifications screen
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
