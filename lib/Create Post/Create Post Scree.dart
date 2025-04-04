// // screens/create_post_screen.dart

// import 'package:achno/Controllers/Home%20Controller/Post%20Controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class CreatePostScreen extends StatelessWidget {
//   final PostController postController = Get.put(PostController());

//   // Function to create a text post
//   void _createTextPost() {
//     postController.createPost(false);
//   }

//   // Function to create a voice post
//   void _createVoicePost(XFile audioFile) {
//     postController.createPost(true, audioFile: audioFile);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Create Post')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(
//           () => Column(
//             children: [
//               // Post Content - Text Field
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Describe your need here...',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   postController.postContent.value = value;
//                 },
//               ),
//               const SizedBox(height: 12),

//               // Voice Post Button
//               ElevatedButton(
//                 onPressed: () async {
//                   final picker = ImagePicker();
//                   final audioFile = await picker.pickVideo(source: ImageSource.gallery); // Picking a voice file (audio)
//                   if (audioFile != null) {
//                     _createVoicePost(audioFile);
//                   }
//                 },
//                 child: const Text('Create Voice Post'),
//               ),
//               const SizedBox(height: 12),

//               // Add Photos (Optional)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.photo),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.photo),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.photo),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // City Dropdown
//               DropdownButton<String>(
//                 value: postController.city.value,
//                 onChanged: (newValue) {
//                   postController.city.value = newValue!;
//                 },
//                 items: ['Lahore', 'Karachi', 'Islamabad']
//                     .map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 12),

//               // Activity/Profession Dropdown
//               DropdownButton<String>(
//                 value: postController.serviceType.value,
//                 onChanged: (newValue) {
//                   postController.serviceType.value = newValue!;
//                 },
//                 items: ['Plumber', 'Electrician', 'Driver', 'Chef']
//                     .map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 12),

//               // Post Duration Dropdown
//               DropdownButton<String>(
//                 value: postController.postDuration.value,
//                 onChanged: (newValue) {
//                   postController.postDuration.value = newValue!;
//                 },
//                 items: ['24 Hours', '48 Hours', '72 Hours']
//                     .map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 12),

//               // Submit Button
//               ElevatedButton(
//                 onPressed: _createTextPost,
//                 child: const Text('Submit'),
//               ),
//               const SizedBox(height: 12),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// screens/create_post_screen.dart

import 'package:achno/Controllers/Home%20Controller/Post%20Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final PostController postController = Get.put(PostController());
  FlutterSoundRecorder? _audioRecorder;
  FlutterSoundPlayer? _audioPlayer;
  bool isRecording = false;
  String? filePath;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _audioPlayer = FlutterSoundPlayer();
  }

  // Start or stop voice recording
  void _toggleRecording() async {
    if (isRecording) {
      // Stop recording
      await _audioRecorder!.stopRecorder();
      setState(() {
        isRecording = false;
      });
    } else {
      // Start recording
      await _audioRecorder!.startRecorder(toFile: 'audio_post.aac');
      setState(() {
        isRecording = true;
      });
    }
  }

  // Submit the post
  void _submitPost() {
    if (filePath != null) {
      postController.createPost(true, audioFile: XFile(filePath!));
    } else {
      postController.createPost(false);
    }
  }

  // Play the voice post
  void _togglePlayback() async {
    if (isPlaying) {
      await _audioPlayer!.stopPlayer();
      setState(() {
        isPlaying = false;
      });
    } else {
      await _audioPlayer!.startPlayer(fromURI: filePath);
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Post Content (Text)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Describe your need here...',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  postController.postContent.value = value;
                },
              ),
              const SizedBox(height: 16),

              // Voice Recording Section
              GestureDetector(
                onTap: _toggleRecording,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isRecording
                        ? const Text('Recording...', style: TextStyle(color: Colors.red))
                        : const Text('Tap to Record Voice', style: TextStyle(color: Colors.green)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Play Voice Post
              if (filePath != null)
                GestureDetector(
                  onTap: _togglePlayback,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: isPlaying
                          ? const Text('Playing...', style: TextStyle(color: Colors.red))
                          : const Text('Tap to Play Voice', style: TextStyle(color: Colors.green)),
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _submitPost,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 16),

              // Add Photos (Optional)
              const Text('Add Photos (Optional)'),
              Row(
                children: List.generate(3, (index) {
                  return IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () {
                      // Handle photo selection
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),

              // City Dropdown
              DropdownButton<String>(
                value: postController.city.value,
                onChanged: (newValue) {
                  postController.city.value = newValue!;
                },
                items: ['Lahore', 'Karachi', 'Islamabad']
                    .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 16),

              // Activity/Profession Dropdown
              DropdownButton<String>(
                value: postController.serviceType.value,
                onChanged: (newValue) {
                  postController.serviceType.value = newValue!;
                },
                items: ['Plumber', 'Electrician', 'Driver', 'Chef']
                    .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 16),

              // Post Duration Dropdown
              DropdownButton<String>(
                value: postController.postDuration.value,
                onChanged: (newValue) {
                  postController.postDuration.value = newValue!;
                },
                items: ['24 Hours', '48 Hours', '72 Hours']
                    .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
