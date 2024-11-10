import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/canceledTaskListController.dart';
import 'package:task_manager/widgets/snackBar_message.dart';
import '../widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  static const String name = "/CanceledTaskScreen";

  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  final CanceledTaskListController _canceledTaskListController =
      Get.find<CanceledTaskListController>();

  @override
  void initState() {
    _getCanceledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CanceledTaskListController>(
      builder: (canceledTaskController) {
        return Visibility(
          visible: !canceledTaskController.inProgress,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              _getCanceledTaskList();
            },
            child: ListView.separated(
              itemCount: canceledTaskController.canceledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: canceledTaskController.canceledTaskList[index],
                  onRefreshList: _getCanceledTaskList,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _getCanceledTaskList() async {
    final bool result = await _canceledTaskListController.getCanceledTaskList();
    if (result == false) {
      showSnackBar(
        context,
        _canceledTaskListController.errorMessage!,
        true,
      );
    }
  }
}
