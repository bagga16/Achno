

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
import 'dart:io';
import 'package:achno/Controllers/chating%20Controllers/Chat%20controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';

class ChatView extends StatefulWidget {
  final String currentUser;
  final String otherUser;
  const ChatView({required this.currentUser, required this.otherUser, super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatController controller = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();
  final record = AudioRecorder();
  File? recordedFile;
  String? duration;

  @override
  void initState() {
    super.initState();
    controller.listenToMessages(widget.currentUser, widget.otherUser);
  }

  // Start recording voice message
  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      await record.start(const RecordConfig(), path: '/tmp_recording.aac');
    }
  }

  // Stop recording voice message
  Future<void> stopRecording() async {
    final path = await record.stop();
    if (path != null) {
      recordedFile = File(path);
      duration = '0:30'; // Placeholder, replace with actual duration
      await controller.sendVoiceMessage(widget.currentUser, widget.otherUser, recordedFile!, duration!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.otherUser)),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final msg = controller.messages[index];
                return Align(
                  alignment: msg.sender == widget.currentUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg.isVoiceMessage ? Colors.orange : Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: msg.isVoiceMessage
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.volume_up, color: Colors.white),
                              const SizedBox(width: 8),
                              Text('Voice (${msg.duration})', style: const TextStyle(color: Colors.white)),
                            ],
                          )
                        : Text(msg.message, style: const TextStyle(color: Colors.white)),
                  ),
                );
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () async {
                    await startRecording();
                    await Future.delayed(const Duration(seconds: 3)); // simulate
                    await stopRecording();
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (textController.text.trim().isNotEmpty) {
                      controller.sendTextMessage(widget.currentUser, widget.otherUser, textController.text.trim());
                      textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
