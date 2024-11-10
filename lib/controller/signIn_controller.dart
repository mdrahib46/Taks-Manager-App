import 'package:get/get.dart';
import 'package:task_manager/controller/authcontroller.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import '../data/utils/urls.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String pass) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {'email': email, "password": pass,};

    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: requestBody);
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
