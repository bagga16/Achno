// models/message_model.dart

class MessageModel {
  final String sender;
  final String message;
  final String timestamp;
  final bool isVoiceMessage;
  final String duration;

  MessageModel({
    required this.sender,
    required this.message,
    required this.timestamp,
    required this.isVoiceMessage,
    required this.duration,
  });
}
