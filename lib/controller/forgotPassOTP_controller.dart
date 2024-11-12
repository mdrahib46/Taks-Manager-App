import 'package:get/get.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/screens/reset_password_screen.dart';

class ForgotPassOTPVerityController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> getForgotPassOTPVerifyController(String email,
      String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.verifyOTP(email, otp),
    );
    if (response.isSuccess) {
      Get.toNamed(ResetPasswordScreen.name, arguments: {
        email,
        otp,
      });
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
