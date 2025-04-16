

// import 'package:achno/Models/Post%20Model.dart';
// import 'package:achno/Models/User%20Model.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

// class PostCard extends StatelessWidget {
//   final PostModel post;
//   final UserModel user;

//   const PostCard({super.key, required this.post, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     final player = AudioPlayer();
//     if (post.audioUrl != null) player.setUrl(post.audioUrl!);

//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 3)),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // User Info Row
//           Row(
//             children: [
//               CircleAvatar(backgroundImage: NetworkImage(user.profileImage)),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
//                   Row(
//                     children: [
//                       _tag(post.userId, bg: Colors.green),
//                       const SizedBox(width: 4),
//                       _tag(user.activity),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       _stars(user.rating ?? 0.0), // Handle null rating
//                       const SizedBox(width: 6),
//                       const Text("1.2 km away", style: TextStyle(fontSize: 12)),
//                       const SizedBox(width: 6),
//                       Text("• Expires in ${post.durationHours } days", style: const TextStyle(fontSize: 12)),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),

//           // Post Text or Audio
//           if (post.text != null)
//             Text(post.text!, style: const TextStyle(fontSize: 16)),
//           if (post.audioUrl != null)
//             Container(
//               margin: const EdgeInsets.only(top: 10),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE6F0EF),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.play_arrow),
//                     onPressed: () => player.play(),
//                   ),
//                   const Text("0:24", style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//           const SizedBox(height: 10),

//           // Footer
//           Row(
//             children: [
//               Icon(Icons.favorite_border, color: Colors.red),
//               const SizedBox(width: 4),
//               Text("${post.likes}"),
//               const SizedBox(width: 16),
//               const Icon(Icons.chat_bubble_outline),
//               const SizedBox(width: 4),
//               Text("${post.responses} responses"),
//               const Spacer(),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.red,
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 ),
//                 onPressed: () {},
//                 child: const Text("Respond"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _tag(String label, {Color bg = const Color(0xFF16706E)}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//       decoration: BoxDecoration(
//         color: bg,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
//     );
//   }

//   Widget _stars(double rating) {
//     return Row(
//       children: List.generate(5, (i) {
//         return Icon(
//           Icons.star,
//           size: 14,
//           color: i < rating.round() ? Colors.amber : Colors.grey.shade300,
//         );
//       }),
//     );
//   }
// }


import 'package:achno/Models/Post%20Model.dart';
import 'package:achno/Models/User%20Model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final UserModel user;

  const PostCard({super.key, required this.post, required this.user});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.post.audioUrl != null) {
      _initializeAudio();
    }
  }

  Future<void> _initializeAudio() async {
    try {
      await _player.setUrl(widget.post.audioUrl!);
      _player.durationStream.listen((d) {
        if (d != null && mounted) {
          setState(() => _duration = d);
        }
      });
      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() => _isPlaying = false);
          _player.seek(Duration.zero);
        }
      });
    } catch (e) {
      print('Audio load error: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final user = widget.user;

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
          /// 👤 Header
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(user.profileImage), radius: 25),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Row(children: [
                    _tag("Request", bg: const Color(0xFF1AA39A)),
                    const SizedBox(width: 4),
                    _tag(user.activity, bg: const Color(0xFF048A7D)),
                  ]),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _stars(user.rating ?? 0),
                      const SizedBox(width: 6),
                      const Text("1.2 km away", style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 6),
                      Text("• Expires in ${post.durationHours ?? 0} days",
                          style: const TextStyle(fontSize: 12)),
                    ],
                  )
                ]),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 📝 Post Text
          if (post.text != null)
            Text(post.text!, style: const TextStyle(fontSize: 16, height: 1.4)),

          /// 🔊 Voice (if any)
          if (post.audioUrl != null)
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFA1D6D1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: () async {
                      if (_isPlaying) {
                        await _player.pause();
                      } else {
                        await _player.seek(Duration.zero);
                        await _player.play();
                      }
                      setState(() => _isPlaying = !_isPlaying);
                    },
                  ),
                  Text(
                    _formatDuration(_duration),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 12),

          /// 🔻 Footer Buttons
          Row(
            children: [
              const Icon(Icons.favorite_border, color: Colors.red),
              const SizedBox(width: 4),
              Text("${post.likes ?? 0}"),
              const SizedBox(width: 16),
              const Icon(Icons.chat_bubble_outline),
              const SizedBox(width: 4),
              Text("${post.responses ?? 0} responses"),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Add your respond logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE94F4F),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
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
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
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
