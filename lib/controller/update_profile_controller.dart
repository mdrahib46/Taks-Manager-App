import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../data/Service/network_caller.dart';
import '../data/models/network_response.dart';
import '../data/models/user_model.dart';
import '../data/utils/urls.dart';
import 'authcontroller.dart';

class ProfileController extends GetxController {
  bool _isProfileInProgress = false;
  String? _errorMessage;

  bool get inProgress => _isProfileInProgress;
  String? get errorMessage => _errorMessage;

  // Method to compress and encode image
  Future<String?> compressAndEncodeImage(XFile imageFile) async {
    try {
      // Decode the image file to an `image` package format
      img.Image image = img.decodeImage(await imageFile.readAsBytes())!;

      // Resize the image
      img.Image resizedImage = img.copyResize(image, width: 300);

      // Compress the resized image
      List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 80);

      // Encode to Base64
      return base64Encode(compressedBytes);
    } catch (e) {
      Get.snackbar('Error', 'Image compression failed: $e',
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<bool> updateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    String? password,
    XFile? selectedImage,
  }) async {
    bool isSuccess = false;
    _isProfileInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password != null && password.isNotEmpty) {
      requestBody['password'] = password;
    }

    if (selectedImage != null) {
      String? compressedImage = await compressAndEncodeImage(selectedImage);
      if (compressedImage != null) {
        requestBody['photo'] = compressedImage;
      }
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );

    _isProfileInProgress = false;
    update();

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthController.saveUserData(userModel);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    return isSuccess;
  }
}
