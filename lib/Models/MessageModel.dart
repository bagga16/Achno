// class MessageModel {
//   final String sender;
//   final String message;
//   final String timestamp;
//   final bool isVoiceMessage;
//   final String duration;

//   MessageModel({
//     required this.sender,
//     required this.message,
//     required this.timestamp,
//     required this.isVoiceMessage,
//     required this.duration,
//   });

//   factory MessageModel.fromJson(Map<String, dynamic> json) {
//     return MessageModel(
//       sender: json['sender'],
//       message: json['message'],
//       timestamp: json['timestamp'],
//       isVoiceMessage: json['isVoiceMessage'],
//       duration: json['duration'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'sender': sender,
//     'message': message,
//     'timestamp': timestamp,
//     'isVoiceMessage': isVoiceMessage,
//     'duration': duration,
//   };
// }

class MessageModel {
  final String senderId;
  final String receiverId;
  final String? text;
  final String? audioUrl;
  final DateTime timestamp;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    this.text,
    this.audioUrl,
    required this.timestamp,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      text: map['text'],
      audioUrl: map['audioUrl'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'audioUrl': audioUrl,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
