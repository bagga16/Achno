// screens/chat_screen.dart

import 'package:achno/Models/MessageModel.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final MessageModel message;

  const ChatScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message.sender),
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
            child: ListView(
              children: [
                // Add chat bubbles here with timestamp and sender
                ListTile(
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(message.message),
                  ),
                  subtitle: Text(message.timestamp),
                ),
                // Add voice messages as well if isVoiceMessage is true
                if (message.isVoiceMessage)
                  ListTile(
                    leading: Icon(Icons.volume_up),
                    title: Text('Voice message (${message.duration})'),
                    subtitle: Text(message.timestamp),
                  ),
              ],
            ),
          ),
          // Input area for sending messages
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
