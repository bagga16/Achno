
import 'package:achno/App%20Screens/Home%20Screens/Notifications.dart';
import 'package:achno/App%20Widgets/PostCard.dart';
import 'package:achno/Controllers/Home%20Controller/HomeController.dart';
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
              Get.to(() => NotificationsScreen());  // Navigate to notifications screen
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
       );
  }
   }

// // screens/home_screen.dart

// import 'package:achno/Common%20Components/Custom%20Bottom%20Bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;  // Track selected tab index

//   // List of screens for each tab
//   final List<Widget> _screens = [
//     HomeScreenContent(),  // Home screen content
//     MessagesScreen(),     // Messages screen content
//     NotificationsScreen(),  // Notifications screen content
//     ProfileScreen(),       // Profile screen content
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;  // Update selected index
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hello Ahmad'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Add search functionality if needed
//             },
//           ),
//         ],
//       ),
//       body: _screens[_selectedIndex],  // Display the selected screen

//       bottomNavigationBar: CustomBottomNavigationBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,  // Handle tap on bottom navigation items
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Action for the + button (e.g., creating a new post)
//           print("Floating action button pressed");
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.white,  // White color for the FAB
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,  // Center the FAB
//     );
//   }
// }

// // Dummy screen widgets for each tab
// class HomeScreenContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("Home Screen Content"),
//     );
//   }
// }

// class MessagesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("Messages Screen Content"),
//     );
//   }
// }

// class NotificationsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("Notifications Screen Content"),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("Profile Screen Content"),
//     );
//   }
// }
