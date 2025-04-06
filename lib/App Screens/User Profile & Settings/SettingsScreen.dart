// import 'package:achno/App%20Screens/User%20Profile%20&%20Settings/User%20Profile%20Screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   bool isNotificationEnabled = true;

//   // Show logout confirmation dialog
//   void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Logout'),
//           content: const Text('Are you sure you want to log out?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//             TextButton(
//               child: const Text('Logout'),
//               onPressed: () {
//                 // Perform logout functionality here
//                 print('Logging out...');
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Show delete account confirmation dialog
//   void _showDeleteAccountDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Account'),
//           content: const Text('Are you sure you want to delete your account?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//             TextButton(
//               child: const Text('Delete'),
//               onPressed: () {
//                 // Perform account deletion functionality here
//                 print('Deleting account...');
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings & Privacy'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: ListView(
//         children: [
//           // Personal Details Row
//           ListTile(
//             title: const Text('Personal Details'),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               Get.to(ProfileScreen());
//               print("Navigating to Personal Details screen...");
//             },
//           ),
          
//           // Account Row
//           ListTile(
//             title: const Text('Account'),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               // Navigate to Account screen
//               print("Navigating to Account screen...");
//             },
//           ),
          
//           // Notifications Row with Switch
//           ListTile(
//             title: const Text('Notifications'),
//             trailing: Switch(
//               value: isNotificationEnabled,
//               onChanged: (bool value) {
//                 setState(() {
//                   isNotificationEnabled = value;
//                 });
//               },
//             ),
//           ),
          
//           // Security Setting Row
//           ListTile(
//             title: const Text('Security Setting'),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               // Navigate to Security Setting screen
//               print("Navigating to Security Setting screen...");
//             },
//           ),
          
//           // Language Row
//           ListTile(
//             title: const Text('Language'),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               // Navigate to Language screen
//               print("Navigating to Language screen...");
//             },
//           ),
          
//           // Privacy Policy Row
//           ListTile(
//             title: const Text('Privacy Policy'),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               // Navigate to Privacy Policy screen
//               print("Navigating to Privacy Policy screen...");
//             },
//           ),
          
//           // Terms of Services Row
//           ListTile(
//             title: const Text('Terms of Services'),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               // Navigate to Terms of Services screen
//               print("Navigating to Terms of Services screen...");
//             },
//           ),
          
//           // Delete Account Row with Alert
//           ListTile(
//             title: const Text('Delete Account'),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               _showDeleteAccountDialog(); // Show delete account confirmation
//             },
//           ),
          
//           // Logout Row with Alert
//           ListTile(
//             title: const Text('Logout', style: TextStyle(color: Colors.red)),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               _showLogoutDialog(); // Show logout confirmation
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:achno/App%20Screens/User%20Profile%20&%20Settings/User%20Profile%20Screen.dart';
import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationEnabled = true;
  final AuthController authController = Get.find<AuthController>();  // Get AuthController instance

  // Show logout confirmation dialog
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () async {
                // Call the logout function from AuthController
                await authController.signOut();
                Navigator.of(context).pop(); // Close the dialog
                Get.offAllNamed('/login');  // Navigate to login screen
              },
            ),
          ],
        );
      },
    );
  }

  // Show delete account confirmation dialog
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                // Call the delete account function from AuthController
                await authController.deleteAccount();
                Navigator.of(context).pop(); // Close the dialog
                Get.offAllNamed('/login');  // Navigate to login screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Privacy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          // Personal Details Row
          ListTile(
            title: const Text('Personal Details'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(ProfileScreen());
              print("Navigating to Personal Details screen...");
            },
          ),
          
          // Account Row
          ListTile(
            title: const Text('Account'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Account screen
              print("Navigating to Account screen...");
            },
          ),
          
          // Notifications Row with Switch
          ListTile(
            title: const Text('Notifications'),
            trailing: Switch(
              value: isNotificationEnabled,
              onChanged: (bool value) {
                setState(() {
                  isNotificationEnabled = value;
                });
              },
            ),
          ),
          
          // Security Setting Row
          ListTile(
            title: const Text('Security Setting'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Security Setting screen
              print("Navigating to Security Setting screen...");
            },
          ),
          
          // Language Row
          ListTile(
            title: const Text('Language'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Language screen
              print("Navigating to Language screen...");
            },
          ),
          
          // Privacy Policy Row
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Privacy Policy screen
              print("Navigating to Privacy Policy screen...");
            },
          ),
          
          // Terms of Services Row
          ListTile(
            title: const Text('Terms of Services'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Terms of Services screen
              print("Navigating to Terms of Services screen...");
            },
          ),
          
          // Delete Account Row with Alert
          ListTile(
            title: const Text('Delete Account'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showDeleteAccountDialog(); // Show delete account confirmation
            },
          ),
          
          // Logout Row with Alert
          ListTile(
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showLogoutDialog(); // Show logout confirmation
            },
          ),
        ],
      ),
    );
  }
}

