
// import 'package:achno/App%20Screens/Chat%20Screens/Chat%20Screen.dart';
// import 'package:achno/Controllers/chating%20Controllers/All%20chats%20Controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MessageListView extends StatelessWidget {
//   final String currentUser;
//   const MessageListView({super.key, required this.currentUser});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(MessageListController());
//     controller.fetchAllUsers();  // Fetch all users

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Messages'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               controller.fetchAllUsers();  // Refresh user list
//             },
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.users.isEmpty) {
//           return Center(child: CircularProgressIndicator());  // Show loading indicator
//         }

//         return ListView.builder(
//           itemCount: controller.users.length,
//           itemBuilder: (context, index) {
//             final user = controller.users[index];
//             final userName = user['name'];
//             final userEmail = user['email'];

//             // Don't allow the current user to start a conversation with themselves
//             if (userEmail == currentUser) {
//               return SizedBox.shrink(); // Skip if it's the current user
//             }

//             return ListTile(
//               leading: const CircleAvatar(child: Icon(Icons.person)),
//               title: Text(userName),
//               subtitle: Text(userEmail),
//               onTap: () {
//                 // Navigate to the chat screen with the selected user
//                 Get.to(() => ChatView(
//                   currentUser: currentUser,
//                   otherUser: userEmail,  // Pass the email as the identifier
//                 ));
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:achno/App%20Screens/Chat%20Screens/Chat%20Screen.dart';
import 'package:achno/Controllers/chating%20Controllers/All%20chats%20Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageListView extends StatelessWidget {
  final String currentUser;
  const MessageListView({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessageListController());
    controller.fetchChatUsers(currentUser);  // Fetch users that the current user has conversations with

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.fetchChatUsers(currentUser);  // Refresh user list
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return Center(child: CircularProgressIndicator());  // Show loading indicator
        }

        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            final userName = user['name'];
            final userEmail = user['email'];

            // Skip if it's the current user
            if (userEmail == currentUser) {
              return SizedBox.shrink();
            }

            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(userName),
              subtitle: Text(userEmail),
              onTap: () {
                // Navigate to the chat screen with the selected user
                Get.to(() => ChatView(
                  currentUser: currentUser,
                  otherUser: userEmail,  // Pass the email as the identifier
                ));
              },
            );
          },
        );
      }),
    );
  }
}
