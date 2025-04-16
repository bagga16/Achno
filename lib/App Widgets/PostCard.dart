
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
import 'package:achno/Models/User%20Model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final UserModel user;

  const PostCard({super.key, required this.post, required this.user});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    if (post.audioUrl != null) player.setUrl(post.audioUrl!);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(user.profileImage)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      _tag(post.userId, bg: Colors.green),
                      const SizedBox(width: 4),
                      _tag(user.activity),
                    ],
                  ),
                  Row(
                    children: [
                      _stars(user.rating ?? 0.0), // Handle null rating
                      const SizedBox(width: 6),
                      const Text("1.2 km away", style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 6),
                      Text("• Expires in ${post.durationHours } days", style: const TextStyle(fontSize: 12)),
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Post Text or Audio
          if (post.text != null)
            Text(post.text!, style: const TextStyle(fontSize: 16)),
          if (post.audioUrl != null)
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F0EF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () => player.play(),
                  ),
                  const Text("0:24", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          const SizedBox(height: 10),

          // Footer
          Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.red),
              const SizedBox(width: 4),
              Text("${post.likes}"),
              const SizedBox(width: 16),
              const Icon(Icons.chat_bubble_outline),
              const SizedBox(width: 4),
              Text("${post.responses} responses"),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                onPressed: () {},
                child: const Text("Respond"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tag(String label, {Color bg = const Color(0xFF16706E)}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _stars(double rating) {
    return Row(
      children: List.generate(5, (i) {
        return Icon(
          Icons.star,
          size: 14,
          color: i < rating.round() ? Colors.amber : Colors.grey.shade300,
        );
      }),
    );
  }
}
