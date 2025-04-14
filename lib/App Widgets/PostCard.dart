
// import 'package:flutter/material.dart';
// import 'package:achno/Models/Post%20Model.dart';

// class PostCard extends StatelessWidget {
//   final Post post;

//   const PostCard({Key? key, required this.post}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Profile Info: Profile Picture, Username, and User Type
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(post.profileImage),
//                   radius: 30,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         post.username,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         post.userType,
//                         style: const TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
            
//             // Post Title and Description
//             Text(
//               post.userType,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 6),
//             Text(post.postContent),
            
//             // Location and Time Info
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 const Icon(Icons.location_on, size: 16, color: Colors.green),
//                 Text(post.distance),
//                 const SizedBox(width: 12),
//                 Text(post.timeLeft),
//               ],
//             ),

//             // Post Type (Request/Service)
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text(post.serviceType),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueAccent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text('Respond'),
//                 ),
//               ],
//             ),
            
//             // Show Voice Message or Regular Post Message
//             const SizedBox(height: 8),
//             if (post.isVoicePost) 
//               Row(
//                 children: [
//                   const Icon(Icons.volume_up, size: 20),
//                   const SizedBox(width: 8),
//                   Text('Voice message (${post.timestamp})'),
//                 ],
//               )
//             else 
//               Row(
//                 children: [
//                   const Icon(Icons.text_fields, size: 20),
//                   const SizedBox(width: 8),
//                   const Text('Text message'),
//                 ],
//               ),

//             // Ratings and Responses
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.star, size: 16, color: Colors.orange),
//                 Text('${post.rating ?? 0} (${post.responses}) responses'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:achno/Models/Post%20Model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    if (post.audioUrl != null) {
      player.setUrl(post.audioUrl!);
    }

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.text ?? '', style: const TextStyle(fontSize: 16)),
            if (post.audioUrl != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.play_arrow), onPressed: () => player.play()),
                  IconButton(icon: const Icon(Icons.pause), onPressed: () => player.pause()),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Text(
              post.createdAt.toLocal().toString().split('.')[0],
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
