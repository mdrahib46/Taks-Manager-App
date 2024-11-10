import 'package:get/get.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import '../data/utils/urls.dart';


class NewTaskListController extends GetxController{
  bool _inprogress = false;

  String? _errorMessage;
  List<TaskModel> _taskList = [];

  bool get inProgress => _inprogress;
  String? get errorMessage =>  _errorMessage;
  List<TaskModel> get taskList =>_taskList;

  Future<bool> getNewTaskList() async{
    bool isSuccess = false;
    _inprogress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskList);
    if(response.isSuccess){
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _taskList = taskListModel.taskList ?? [];
      isSuccess = true;
    }
    else{
      _errorMessage = response.errorMessage;
    }
    _inprogress = false;
    update();

    return isSuccess;
  }
}