

// import 'package:achno/Controllers/Home%20Controller/Post%20Controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:image_picker/image_picker.dart';

// class CreatePostScreen extends StatefulWidget {
//   const CreatePostScreen({Key? key}) : super(key: key);

//   @override
//   _CreatePostScreenState createState() => _CreatePostScreenState();
// }

// class _CreatePostScreenState extends State<CreatePostScreen> {
//   final PostController postController = Get.put(PostController());
//   FlutterSoundRecorder? _audioRecorder;
//   FlutterSoundPlayer? _audioPlayer;
//   bool isRecording = false;
//   String? filePath;
//   bool isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _audioRecorder = FlutterSoundRecorder();
//     _audioPlayer = FlutterSoundPlayer();
//   }

//   // Start or stop voice recording
//   void _toggleRecording() async {
//     if (isRecording) {
//       // Stop recording
//       await _audioRecorder!.stopRecorder();
//       setState(() {
//         isRecording = false;
//       });
//     } else {
//       // Start recording
//       await _audioRecorder!.startRecorder(toFile: 'audio_post.aac');
//       setState(() {
//         isRecording = true;
//       });
//     }
//   }

//   // Submit the post
//   void _submitPost() {
//     if (filePath != null) {
//       postController.createPost(true, audioFile: XFile(filePath!));
//     } else {
//       postController.createPost(false);
//     }
//   }

//   // Play the voice post
//   void _togglePlayback() async {
//     if (isPlaying) {
//       await _audioPlayer!.stopPlayer();
//       setState(() {
//         isPlaying = false;
//       });
//     } else {
//       await _audioPlayer!.startPlayer(fromURI: filePath);
//       setState(() {
//         isPlaying = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Create Post')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(
//           () => Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Post Content (Text)
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Describe your need here...',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   postController.postContent.value = value;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Voice Recording Section
//               GestureDetector(
//                 onTap: _toggleRecording,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 12.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.green, width: 2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: isRecording
//                         ? const Text('Recording...', style: TextStyle(color: Colors.red))
//                         : const Text('Tap to Record Voice', style: TextStyle(color: Colors.green)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Play Voice Post
//               if (filePath != null)
//                 GestureDetector(
//                   onTap: _togglePlayback,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 12.0),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.green, width: 2),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: isPlaying
//                           ? const Text('Playing...', style: TextStyle(color: Colors.red))
//                           : const Text('Tap to Play Voice', style: TextStyle(color: Colors.green)),
//                     ),
//                   ),
//                 ),
//               const SizedBox(height: 16),

//               // Submit Button
//               ElevatedButton(
//                 onPressed: _submitPost,
//                 child: const Text('Submit'),
//               ),
//               const SizedBox(height: 16),

//               // Add Photos (Optional)
//               const Text('Add Photos (Optional)'),
//               Row(
//                 children: List.generate(3, (index) {
//                   return IconButton(
//                     icon: const Icon(Icons.photo),
//                     onPressed: () {
//                       // Handle photo selection
//                     },
//                   );
//                 }),
//               ),
//               const SizedBox(height: 16),

//               // City Dropdown
//               DropdownButton<String>(
//                 value: postController.city.value,
//                 onChanged: (newValue) {
//                   postController.city.value = newValue!;
//                 },
//                 items: ['Lahore', 'Karachi', 'Islamabad']
//                     .map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//               ),
//               const SizedBox(height: 16),

//               // Activity/Profession Dropdown
//               DropdownButton<String>(
//                 value: postController.serviceType.value,
//                 onChanged: (newValue) {
//                   postController.serviceType.value = newValue!;
//                 },
//                 items: ['Plumber', 'Electrician', 'Driver', 'Chef']
//                     .map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//               ),
//               const SizedBox(height: 16),

//               // Post Duration Dropdown
//               DropdownButton<String>(
//                 value: postController.postDuration.value,
//                 onChanged: (newValue) {
//                   postController.postDuration.value = newValue!;
//                 },
//                 items: ['24 Hours', '48 Hours', '72 Hours']
//                     .map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:achno/Controllers/Home%20Controller/Post%20Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';

class CreatePostView extends StatelessWidget {
  CreatePostView({super.key});

  final postController = Get.put(PostController());
  final textController = TextEditingController();

  final RxString selectedCity = 'Lahore'.obs;
  final RxString selectedProfession = 'Plumbers'.obs;
  final RxString selectedDuration = '48 Hours'.obs;

  final List<String> cities = ['Lahore', 'Casablanca', 'Riyadh'];
  final List<String> professions = ['Plumbers', 'Electricians', 'Cleaners'];
  final List<String> durations = ['24 Hours', '48 Hours', '72 Hours'];

  final RxList<XFile> selectedImages = <XFile>[].obs;

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      selectedImages.assignAll(picked.take(3));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Post"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text field
            TextField(
              controller: textController,
              maxLines: 4,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Describe your need here...',
                fillColor: const Color(0xFFE6F0EF),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),

            const SizedBox(height: 12),

            // Audio Wave UI
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F0EF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(postController.isRecording.value ? Icons.stop : Icons.mic),
                      onPressed: () {
                        postController.isRecording.value
                            ? postController.stopRecording()
                            : postController.startRecording();
                      },
                    ),
                    if (postController.audioPath.value.isNotEmpty)
                      IconButton(
                        icon: Icon(postController.isPlaying.value ? Icons.pause : Icons.play_arrow),
                        onPressed: () {
                          postController.isPlaying.value
                              ? postController.stopPlayback()
                              : postController.playRecording();
                        },
                      ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 16),

            // Submit Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16706E),
                  minimumSize: Size(width * 0.8, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  postController.createPost(
                    text: textController.text.trim(),
                    city: selectedCity.value,
                    profession: selectedProfession.value,
                    duration: selectedDuration.value,
                    images: selectedImages,
                  );
                },
                child: const Text("Submit"),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Add Photos (optional)", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),

            Obx(() {
              return Row(
                children: List.generate(3, (i) {
                  return GestureDetector(
                    onTap: pickImages,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        image: selectedImages.length > i
                            ? DecorationImage(
                                image: FileImage(File(selectedImages[i].path)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: selectedImages.length <= i
                          ? const Icon(Icons.image, color: Colors.grey)
                          : null,
                    ),
                  );
                }),
              );
            }),

            const SizedBox(height: 16),

            _buildDropdown("City", cities, selectedCity),
            const SizedBox(height: 10),
            _buildDropdown("Activity/Profession", professions, selectedProfession),
            const SizedBox(height: 10),
            _buildDropdown("Post Duration", durations, selectedDuration),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, RxString value) {
    return Obx(() => DropdownButtonFormField<String>(
          value: value.value,
          isExpanded: true,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => value.value = v!,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          ),
        ));
  }
}
