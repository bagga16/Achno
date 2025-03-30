// controllers/message_controller.dart

import 'package:achno/Models/MessageModel.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  // List of messages for the messages screen
  var messages = <MessageModel>[
    MessageModel(
      sender: 'Sarah Johnson',
      message: 'I\'m looking forward to our meeting...',
      timestamp: '10:23 AM',
      isVoiceMessage: true,
      duration: '0:32',
    ),
    MessageModel(
      sender: 'Sarah Johnson',
      message: 'Post: Team Meeting Announcement',
      timestamp: '10:23 AM',
      isVoiceMessage: false,
      duration: '',
    ),
    // Add more sample messages
  ].obs;

  // Logic to mark all messages as read (if applicable)
  void markAllRead() {
    // In this case, we won't change the message status but can handle logic as needed
    // Example: Update status of messages to read.
  }
}
