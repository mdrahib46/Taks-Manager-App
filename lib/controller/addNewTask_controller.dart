import 'package:get/get.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getCreateNewTaskController(
      String title, String description) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New",
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestBody);
    if (response.isSuccess) {
      isSuccess = true;
      // Get.toNamed(NewTaskScreen.name);
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
