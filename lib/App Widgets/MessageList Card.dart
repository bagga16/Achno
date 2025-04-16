
// import 'package:achno/App%20Screens/Chat%20Screens/Chat%20Screen.dart';
// import 'package:achno/Models/User%20Model.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MessagesScreen extends StatelessWidget {
//   final String currentUserId;

//   MessagesScreen({required this.currentUserId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Messages')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('chats')
//             .where('participants', arrayContains: currentUserId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final chats = snapshot.data!.docs;

//           if (chats.isEmpty) {
//             return Center(
//               child: ElevatedButton(
//                 onPressed: () => _showAllUsers(context),
//                 child: const Text("Start Chat"),
//               ),
//             );
//           }

//           return ListView.builder(
//             itemCount: chats.length,
//             itemBuilder: (context, index) {
//               final chat = chats[index];
//               final participants = List<String>.from(chat['participants']);
//               final otherUserId = participants.firstWhere((id) => id != currentUserId);
//               final lastMessage = chat['lastMessage'] ?? '';
//               final timestamp = chat['timestamp'] ?? '';

//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance
//                     .collection('All Users')
//                     .doc(otherUserId)
//                     .get(),
//                 builder: (context, userSnapshot) {
//                   if (!userSnapshot.hasData) {
//                     return const ListTile(title: Text('Loading...'));
//                   }

//                   final doc = userSnapshot.data!;
//                   final raw = doc.data() as Map<String, dynamic>;
//                   final safeMap = {
//                     'uid': doc.id,
//                     'phone': raw['phone'] ?? '',
//                     'fullName': raw['fullName'] ?? '',
//                     'city': raw['city'] ?? '',
//                     'activity': raw['activity'] ?? '',
//                     'textInfo': raw['textInfo'] ?? '',
//                     'videoIntro': raw['videoIntro'] ?? '',
//                     'location': raw['location'] ?? '',
//                     'profileImage': raw['profileImage'] ?? '',
//                     'rating': raw['rating'],
//                     'reviews': raw['reviews'],
//                   };

//                   final user = UserModel.fromMap(safeMap);

//                   return ListTile(
//                     leading: CircleAvatar(backgroundImage: NetworkImage(user.profileImage)),
//                     title: Text(user.fullName),
//                     subtitle: Text(lastMessage),
//                     trailing: Text(
//                       timestamp != ''
//                           ? TimeOfDay.fromDateTime(DateTime.parse(timestamp)).format(context)
//                           : '',
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ChatScreen(
//                             currentUserId: currentUserId,
//                             otherUser: user,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showAllUsers(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (ctx) => FutureBuilder<QuerySnapshot>(
//         future: FirebaseFirestore.instance.collection('All Users').get(),
//         builder: (ctx, snapshot) {
//           if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

//           final users = snapshot.data!.docs
//               .where((doc) => doc.id != currentUserId)
//               .map((doc) {
//                 final raw = doc.data() as Map<String, dynamic>;
//                 final safeMap = {
//                   'uid': doc.id,
//                   'phone': raw['phone'] ?? '',
//                   'fullName': raw['fullName'] ?? '',
//                   'city': raw['city'] ?? '',
//                   'activity': raw['activity'] ?? '',
//                   'textInfo': raw['textInfo'] ?? '',
//                   'videoIntro': raw['videoIntro'] ?? '',
//                   'location': raw['location'] ?? '',
//                   'profileImage': raw['profileImage'] ?? '',
//                   'rating': raw['rating'],
//                   'reviews': raw['reviews'],
//                 };
//                 return UserModel.fromMap(safeMap);
//               }).toList();

//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, i) {
//               final user = users[i];
//               return ListTile(
//                 leading: CircleAvatar(backgroundImage: NetworkImage(user.profileImage)),
//                 title: Text(user.fullName),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => ChatScreen(
//                         currentUserId: currentUserId,
//                         otherUser: user,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:achno/App%20Screens/Chat%20Screens/Chat%20Screen.dart';
import 'package:achno/Models/User%20Model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesScreen extends StatelessWidget {
  final String currentUserId;

  MessagesScreen({required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages')),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('participants', arrayContains: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chats = snapshot.data!.docs;

          if (chats.isEmpty) {
            return const Center(child: Text("No chats yet"));
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              final participants = List<String>.from(chat['participants']);
              final otherUserId = participants.firstWhere((id) => id != currentUserId);
              final lastMessage = chat['lastMessage'] ?? '';
              final timestamp = chat['timestamp'] ?? '';

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('All Users')
                    .doc(otherUserId)
                    .get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const ListTile(title: Text('Loading...'));
                  }

                  final doc = userSnapshot.data!;
                  final raw = doc.data() as Map<String, dynamic>;
                  final safeMap = {
                    'uid': doc.id,
                    'phone': raw['phone'] ?? '',
                    'fullName': raw['fullName'] ?? '',
                    'city': raw['city'] ?? '',
                    'activity': raw['activity'] ?? '',
                    'textInfo': raw['textInfo'] ?? '',
                    'videoIntro': raw['videoIntro'] ?? '',
                    'location': raw['location'] ?? '',
                    'profileImage': raw['profileImage'] ?? '',
                    'rating': raw['rating'],
                    'reviews': raw['reviews'],
                  };

                  final user = UserModel.fromMap(safeMap);

                  return ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(user.profileImage)),
                    title: Text(user.fullName),
                    subtitle: Text(lastMessage),
                    trailing: Text(
                      timestamp != ''
                          ? TimeOfDay.fromDateTime(DateTime.parse(timestamp)).format(context)
                          : '',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            currentUserId: currentUserId,
                            otherUser: user,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => _showAllUsers(context),
        child: const Icon(Icons.chat),
      ),
    );
  }

  void _showAllUsers(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('All Users').get(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final users = snapshot.data!.docs
              .where((doc) => doc.id != currentUserId)
              .map((doc) {
                final raw = doc.data() as Map<String, dynamic>;
                final safeMap = {
                  'uid': doc.id,
                  'phone': raw['phone'] ?? '',
                  'fullName': raw['fullName'] ?? '',
                  'city': raw['city'] ?? '',
                  'activity': raw['activity'] ?? '',
                  'textInfo': raw['textInfo'] ?? '',
                  'videoIntro': raw['videoIntro'] ?? '',
                  'location': raw['location'] ?? '',
                  'profileImage': raw['profileImage'] ?? '',
                  'rating': raw['rating'],
                  'reviews': raw['reviews'],
                };
                return UserModel.fromMap(safeMap);
              }).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, i) {
              final user = users[i];
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(user.profileImage)),
                title: Text(user.fullName),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        currentUserId: currentUserId,
                        otherUser: user,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
