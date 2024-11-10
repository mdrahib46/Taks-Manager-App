import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/inprogress_taskList_controller.dart';
import 'package:task_manager/widgets/snackBar_message.dart';
import '../widgets/task_card.dart';

class InProgressTaskScreen extends StatefulWidget {
  static const String name = "/InProgressTaskScreen";
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  final InProgressTaskListController _inProgressTaskListController =
      Get.find<InProgressTaskListController>();

  @override
  void initState() {
    _getInProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InProgressTaskListController>(
        builder: (inProgressTaskListController) {
      return Visibility(
        visible: !inProgressTaskListController.inProgress,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            _getInProgressTaskList();
          },
          child: ListView.separated(
            itemCount: inProgressTaskListController.inProgressTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel:
                    inProgressTaskListController.inProgressTaskList[index],
                onRefreshList: _getInProgressTaskList,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          ),
        ),
      );
    });
  }

  Future<void> _getInProgressTaskList() async {
    final bool result =
        await _inProgressTaskListController.getInProgressTaskListController();
    if (result == false) {
      showSnackBar(
        context,
        _inProgressTaskListController.errorMessage!,
        true,
      );
    }
  }
}
