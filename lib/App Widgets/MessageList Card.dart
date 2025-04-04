

// import 'package:achno/App%20Screens/Chat%20Screens/Chat%20Screen.dart';
// import 'package:achno/Controllers/chating%20Controllers/MessageController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MessageList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final MessageController messageController = Get.put(MessageController());

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Messages'),  // Title should be "Messages"
//         backgroundColor: Colors.green,  // Matching the theme color
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Add logic for Mark All Read here
//               // For now, just print a message for debugging
//               print("Mark all as read");
//             },
//             icon: const Icon(Icons.done_all),
//           ),
//         ],
//       ),
//       body: Obx(
//         () => ListView.builder(
//           itemCount: messageController.userChats.length,
//           itemBuilder: (context, index) {
//             final userName = messageController.userChats.keys.elementAt(index);
//             final messages = messageController.userChats[userName]!;

//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 elevation: 3,
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.all(12.0),
//                   leading: CircleAvatar(
//                     child: Icon(Icons.person),  // Avatar for each user
//                   ),
//                   title: Text(
//                     userName,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           messages.last.message,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(color: Colors.black.withOpacity(0.7)),
//                         ),
//                       ),
//                       if (messages.last.isVoiceMessage)
//                         Icon(Icons.volume_up, size: 20, color: Colors.grey),
//                       SizedBox(width: 8),
//                       Text(messages.last.timestamp, style: TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                   onTap: () {
//                     // Navigate to the chat screen with the selected user's messages
//                     Get.to(() => ChatScreen(userName: userName, messages: messages));
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle navigation to a new chat screen (if implemented)
//           print("Compose a new message");
//         },
//         child: const Icon(Icons.message),
//         backgroundColor: Colors.green,  // Match the button color with theme
//       ),
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
    controller.fetchChatUsers(currentUser);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.fetchChatUsers(currentUser);
            },
          ),
        ],
      ),
      body: Obx(() => ListView.builder(
        itemCount: controller.chatUsers.length,
        itemBuilder: (context, index) {
          final otherUser = controller.chatUsers[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(otherUser),
            onTap: () {
              Get.to(() => ChatView(
                    currentUser: currentUser,
                    otherUser: otherUser,
                  ));
            },
          );
        },
      )),
    );
  }
}
