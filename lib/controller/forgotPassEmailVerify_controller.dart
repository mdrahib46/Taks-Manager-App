import 'package:get/get.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/screens/forgot_pass_otp_screen.dart';

class ForgotPassEmailVerifyController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getForgotPassEmailVerifyController(String email) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.emailVerification(email));
    if (response.isSuccess) {
    Get.toNamed(ForgotPasswdOTPScreen.name, arguments: email);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
