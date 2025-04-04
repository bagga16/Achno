
// import 'package:achno/App%20Screens/Home%20Screens/Home%20Screen.dart';
// import 'package:achno/App%20Screens/Home%20Screens/Notifications.dart';
// import 'package:achno/App%20Screens/User%20Profile/User%20Profile%20Screen.dart';
// import 'package:achno/App%20Widgets/MessageList%20Card.dart';
// import 'package:achno/Common%20Components/Custom%20Bottom%20Bar.dart';
// import 'package:achno/Create%20Post/Create%20Post%20Scree.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _selectedIndex = 0;

//   // Screens list for navigation
//   final List<Widget> screens = [
//     HomeScreen(),
//     MessageList(),
  
//     NotificationsScreen(),
//     UserProfileScreen(),
//       CreatePostScreen(),
   
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;  // Update selected index
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[_selectedIndex], // Display the selected screen
//       bottomNavigationBar: CustomBottomNavigationBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to the Add Post screen or show Add Post functionality
//           print("Floating Action Button Pressed");
//           _onItemTapped(4); // This will navigate to the "CreatePostScreen"
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.white,  // White color for the FAB
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,  // Center the FAB
//     );
//   }
// }


import 'package:achno/App%20Screens/Home%20Screens/Home%20Screen.dart';
import 'package:achno/App%20Screens/Home%20Screens/Notifications.dart';
import 'package:achno/App%20Screens/User%20Profile%20&%20Settings/SettingsScreen.dart';
import 'package:achno/App%20Screens/User%20Profile%20&%20Settings/User%20Profile%20Screen.dart';
import 'package:achno/App%20Widgets/MessageList%20Card.dart';
import 'package:achno/Common%20Components/Custom%20Bottom%20Bar.dart';
import 'package:achno/Create%20Post/Create%20Post%20Scree.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // Screens list for navigation
  final List<Widget> screens = [
    HomeScreen(),
    MessageListView(currentUser: 'bagga',),
    NotificationsScreen(),
    SettingsScreen(),
    CreatePostScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // Update selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: Container(
        height: 74,
        width: 70,       decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // Outer circle color
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1C8C70), // Inner circle green color
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              color: Colors.white,
              onPressed: () {
                // Navigate to the Add Post screen or show Add Post functionality
                print("Floating Action Button Pressed");
                _onItemTapped(4); // This will navigate to the "CreatePostScreen"
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,  // Center the FAB
    );
  }
}
