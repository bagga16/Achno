

// import 'dart:io';
// import 'package:achno/Controllers/chating%20Controllers/Chat%20controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:record/record.dart';
// class ChatView extends StatefulWidget {
//   final String currentUser;
//   final String otherUser;
//   const ChatView({required this.currentUser, required this.otherUser, super.key});

//   @override
//   State<ChatView> createState() => _ChatViewState();
// }

// class _ChatViewState extends State<ChatView> {
//   final ChatController controller = Get.put(ChatController());
//   final TextEditingController textController = TextEditingController();
//   final record = AudioRecorder();
//   File? recordedFile;
//   String? duration;

//   @override
//   void initState() {
//     super.initState();
//     controller.listenToMessages(widget.currentUser, widget.otherUser);  // Start listening to the messages
//   }

//   // Start recording voice message
//   Future<void> startRecording() async {
//     if (await record.hasPermission()) {
//       await record.start(const RecordConfig(), path: '/tmp_recording.aac');
//     }
//   }

//   // Stop recording voice message
//   Future<void> stopRecording() async {
//     final path = await record.stop();
//     if (path != null) {
//       recordedFile = File(path);
//       duration = '0:30'; // Placeholder, replace with actual duration
//       await controller.sendVoiceMessage(widget.currentUser, widget.otherUser, recordedFile!, duration!);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.otherUser)),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() => ListView.builder(
//               itemCount: controller.messages.length,
//               itemBuilder: (context, index) {
//                 final msg = controller.messages[index];
//                 return Align(
//                   alignment: msg.sender == widget.currentUser
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.all(8),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: msg.isVoiceMessage ? Colors.orange : Colors.blue,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: msg.isVoiceMessage
//                         ? Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(Icons.volume_up, color: Colors.white),
//                               const SizedBox(width: 8),
//                               Text('Voice (${msg.duration})', style: const TextStyle(color: Colors.white)),
//                             ],
//                           )
//                         : Text(msg.message, style: const TextStyle(color: Colors.white)),
//                   ),
//                 );
//               },
//             )),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.mic),
//                   onPressed: () async {
//                     await startRecording();
//                     await Future.delayed(const Duration(seconds: 3)); // simulate
//                     await stopRecording();
//                   },
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: textController,
//                     decoration: const InputDecoration(
//                       hintText: 'Type a message...',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     if (textController.text.trim().isNotEmpty) {
//                       controller.sendTextMessage(widget.currentUser, widget.otherUser, textController.text.trim());
//                       textController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:achno/App%20Widgets/MessageCard.dart';
import 'package:achno/Models/MessageModel.dart';
import 'package:achno/Models/User%20Model.dart';
import 'package:achno/Utils/ChatService.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final UserModel otherUser;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.otherUser,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  late String chatId;

  @override
  void initState() {
    super.initState();
    chatId = _getChatId(widget.currentUserId, widget.otherUser.uid);
  }

  String _getChatId(String id1, String id2) {
    return id1.hashCode <= id2.hashCode ? '$id1\_$id2' : '$id2\_$id1';
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final message = MessageModel(
      senderId: widget.currentUserId,
      receiverId: widget.otherUser.uid,
      text: text,
      audioUrl: null,
      timestamp: DateTime.now(),
    );

    _chatService.sendMessage(chatId, message);
    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 300)).then((_) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.otherUser;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(user.profileImage)),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.fullName, style: const TextStyle(fontSize: 16)),
              const Text("Post: Team Meeting Announcement", style: TextStyle(fontSize: 12)),
            ]),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _chatService.getMessages(chatId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageBubble(
                      message: message,
                      isMe: message.senderId == widget.currentUserId,
                      audioPlayer: _audioPlayer,
                    );
                  },
                );
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      color: Colors.grey[100],
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.mic, color: Color(0xFF16706E)),
            onPressed: () {
              // Implement voice recording here (optional)
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF16706E)),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
