
// import 'package:achno/Models/Post%20Model.dart';
// import 'package:flutter/material.dart';

// class PostCard extends StatelessWidget {
//   final PostModel post;

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
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(post.profileImage),
//               radius: 30,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         post.username,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         post.userType,
//                         style: const TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     post.postTitle,
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(post.postDescription),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       Icon(Icons.location_on, size: 16, color: Colors.green),
//                       Text(post.distance),
//                       const SizedBox(width: 12),
//                       Text(post.timeLeft),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.star, size: 16, color: Colors.orange),
//                       Text('${post.rating} (${post.responses} responses)'),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text(post.postType),
//                         style: ElevatedButton.styleFrom(
//                          backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text('Respond'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// widgets/post_card.dart

import 'package:flutter/material.dart';
import 'package:achno/Models/Post%20Model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(post.profileImage),
                  radius: 30,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        post.userType,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Post Title and Description
            Text(
              post.postTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6),
            Text(post.postDescription),
            
            // Location and Time Info
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.green),
                Text(post.distance),
                const SizedBox(width: 12),
                Text(post.timeLeft),
              ],
            ),

            // Post Type (Request/Service)
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(post.postType),
                  style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {},
                  child: const Text('Respond'),
                ),
              ],
            ),
            
            // Show Voice Message or Regular Post Message
            const SizedBox(height: 8),
            if (post.isVoiceMessage) 
              Row(
                children: [
                  Icon(Icons.volume_up, size: 20),
                  const SizedBox(width: 8),
                  Text('Voice message (${post.duration})'),
                ],
              )
            else 
              Row(
                children: [
                  Icon(Icons.text_fields, size: 20),
                  const SizedBox(width: 8),
                  Text('Text message'),
                ],
              ),

            // Ratings and Responses
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, size: 16, color: Colors.orange),
                Text('${post.rating} (${post.responses} responses)'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
