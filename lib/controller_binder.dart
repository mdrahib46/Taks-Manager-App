import 'package:get/get.dart';
import 'package:task_manager/controller/new_taskList_controller.dart';
import 'package:task_manager/controller/signIn_controller.dart';
import 'controller/canceledTaskListController.dart';
import 'controller/completedTaskListController.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(CompletedTaskListController());
    Get.put(CanceledTaskListController());
  }

}