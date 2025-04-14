import 'dart:io';
import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Models/User Model.dart';
class ProfileController extends GetxController {
  final authController = Get.find<AuthController>();

  final Rx<XFile?> pickedImage = Rx<XFile?>(null);

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) pickedImage.value = image;
  }

  Future<void> saveProfile({
    required String fullName,
    required String phone,
    required String city,
    required String activity,
    required String textInfo,
    required String videoIntro,
  }) async {
    final user = authController.user;
    if (user == null) return;

    String imageUrl = authController.currentUserModel.value?.profileImage ?? '';

    if (pickedImage.value != null) {
      imageUrl = await authController.uploadProfileImage(pickedImage.value!.path);
    }

    final updatedUser = UserModel(
      uid: user.uid,
      phone: phone,
      fullName: fullName,
      city: city,
      activity: activity,
      textInfo: textInfo,
      videoIntro: videoIntro,
      profileImage: imageUrl, location: '',
    );

    await authController.updateUserProfile(updatedUser);
    Get.snackbar('Success', 'Profile updated');
  }
}
