import 'package:get/get.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/screens/signIn_screen.dart';


class ResetPasswordController extends GetxController{

  bool _inProgress = false;
  String?  _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getPasswordResetController(String email, String otp, String password) async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(url: Urls.resetPassword, body:requestBody,);

    if(response.isSuccess){
      Get.offAllNamed(SignInScreen.name);
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }

}