

// import 'package:achno/Models/MessageModel.dart';
// import 'package:flutter/material.dart';

// class ChatScreen extends StatelessWidget {
//   final String userName;
//   final List<MessageModel> messages;

//   const ChatScreen({Key? key, required this.userName, required this.messages}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(userName),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Add more actions for chat, such as profile, settings, etc.
//             },
//             icon: const Icon(Icons.more_vert),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return Column(
//                   children: [
//                     ListTile(
//                       title: Align(
//                         alignment: message.sender == userName
//                             ? Alignment.centerLeft
//                             : Alignment.centerRight,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: message.sender == userName
//                                 ? Colors.blue
//                                 : Colors.grey,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           padding: const EdgeInsets.all(10),
//                           child: Text(
//                             message.message,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       subtitle: Text(message.timestamp),
//                     ),
//                     if (message.isVoiceMessage)
//                       ListTile(
//                         leading: Icon(Icons.volume_up),
//                         title: Text('Voice message (${message.duration})'),
//                         subtitle: Text(message.timestamp),
//                       ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     // Record voice message logic
//                   },
//                   icon: const Icon(Icons.mic),
//                 ),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // Send message logic
//                   },
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// screens/chat_screen.dart

import 'package:achno/Models/MessageModel.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  final List<MessageModel> messages;

  const ChatScreen({Key? key, required this.userName, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        actions: [
          IconButton(
            onPressed: () {
              // Add more actions for chat, such as profile, settings, etc.
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Column(
                  children: [
                    ListTile(
                      title: Align(
                        alignment: message.sender == userName
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: message.sender == userName
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            message.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      subtitle: Text(message.timestamp),
                    ),
                    if (message.isVoiceMessage)
                      ListTile(
                        leading: Icon(Icons.volume_up),
                        title: Text('Voice message (${message.duration})'),
                        subtitle: Text(message.timestamp),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Record voice message logic
                  },
                  icon: const Icon(Icons.mic),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Send message logic
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

