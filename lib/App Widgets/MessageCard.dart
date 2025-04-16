import 'package:achno/Models/MessageModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;
  final AudioPlayer audioPlayer;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isMe ? const Color(0xFF16706E) : const Color(0xFFE5E5E5);
    final textColor = isMe ? Colors.white : Colors.black87;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      margin: EdgeInsets.only(
        left: isMe ? 40 : 8,
        right: isMe ? 8 : 40,
        top: 6,
      ),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: message.audioUrl != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        onPressed: () async {

                         if (message.audioUrl != null && message.audioUrl!.isNotEmpty) {
  try {
    await audioPlayer.setUrl(message.audioUrl!);
    await audioPlayer.play();
  } catch (e) {
    debugPrint("Audio load error: $e");
  }
} else {
  debugPrint("Audio URL is null or empty.");
}

                        },
                      ),
                      const Text("0:32", style: TextStyle(color: Colors.white)),
                    ],
                  )
                : Text(message.text ?? '',
                    style: TextStyle(color: textColor, fontSize: 16)),
          ),
          const SizedBox(height: 2),
          Text(
            DateFormat('hh:mm a').format(message.timestamp),
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
