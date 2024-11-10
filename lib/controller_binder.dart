import 'package:get/get.dart';
import 'package:task_manager/controller/signIn_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
  }

}