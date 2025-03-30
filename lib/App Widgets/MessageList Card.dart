// widgets/message_list.dart

import 'package:achno/App%20Screens/Chat%20Screens/Chat%20Screen.dart';
import 'package:achno/Controllers/MessageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MessageController messageController = Get.put(MessageController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        actions: [
          IconButton(
            onPressed: () {
              messageController.markAllRead(); // Mark all as read logic
            },
            icon: const Icon(Icons.done_all),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: messageController.messages.length,
          itemBuilder: (context, index) {
            final message = messageController.messages[index];
            return ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(message.sender),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Text(message.message),
                  ),
                  if (message.isVoiceMessage)
                    Icon(Icons.volume_up, size: 20),
                  Text(message.timestamp),
                ],
              ),
              onTap: () {
                // Navigate to the chat screen
                Get.to(() => ChatScreen(message: message));
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the new chat screen (if implemented)
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
