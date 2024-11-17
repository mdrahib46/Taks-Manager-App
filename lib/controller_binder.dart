import 'package:get/get.dart';
import 'package:task_manager/controller/addNewTask_controller.dart';
import 'package:task_manager/controller/deleteTaskController.dart';
import 'package:task_manager/controller/forgotPassEmailVerify_controller.dart';
import 'package:task_manager/controller/forgotPassOTP_controller.dart';
import 'package:task_manager/controller/inprogress_taskList_controller.dart';
import 'package:task_manager/controller/new_taskList_controller.dart';
import 'package:task_manager/controller/resetPass_controller.dart';
import 'package:task_manager/controller/signIn_controller.dart';
import 'package:task_manager/controller/update_profile_controller.dart';
import 'controller/canceledTaskListController.dart';
import 'controller/completedTaskListController.dart';
import 'controller/signUp_controller.dart';
import 'controller/taskStatus_controller.dart';
import 'controller/task_status_count_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(CompletedTaskListController());
    Get.put(CanceledTaskListController());
    Get.put(InProgressTaskListController());
    Get.put(SignupController());
    Get.put(AddNewTaskController());
    Get.put(ForgotPassEmailVerifyController());
    Get.put(ForgotPassOTPVerityController());
    Get.put(ResetPasswordController());
    Get.put(DeleteTaskController());
    Get.put(UpdateTaskStatusController());
    Get.put(TaskStatusCountController());
    Get.put(ProfileController());
  }
}
