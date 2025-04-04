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

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      sender: json['sender'],
      message: json['message'],
      timestamp: json['timestamp'],
      isVoiceMessage: json['isVoiceMessage'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() => {
    'sender': sender,
    'message': message,
    'timestamp': timestamp,
    'isVoiceMessage': isVoiceMessage,
    'duration': duration,
  };
}
