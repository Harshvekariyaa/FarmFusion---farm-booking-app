import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userName = 'Name'.obs;
  var userEmail = 'Email'.obs;
  var profileImage = 'assets/images/splashImage.jpeg'.obs;

  // Method to update the profile information
  void updateProfile(String name, String email, String imagePath) {
    userName.value = name;
    userEmail.value = email;
    profileImage.value = imagePath;
  }
}

class ProfileImageWidget extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Handle tap event
            print("Profile image tapped");
          },
          child: Obx(() => Container(
            height: Get.height / 7,
            width: Get.width / 3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26,
              image: DecorationImage(
                image: AssetImage(profileController.profileImage.value),
                fit: BoxFit.cover,
              ),
            ),
          )),
        ),
        SizedBox(height: 20),
        Obx(() => Text(
          profileController.userName.value,
          style: TextStyle(
            fontSize: 19,
            fontFamily: 'LocalFont',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        )),
        Obx(() => Text(
          profileController.userEmail.value,
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'LocalFont',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        )),
      ],
    );
  }
}
