import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/controller/completedTaskListController.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/widgets/snackBar_message.dart';
import '../data/Service/network_caller.dart';
import '../data/utils/urls.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _inProgress = false;
  final CompletedTaskListController _completedTaskListController = Get.find<
      CompletedTaskListController>();

  @override
  void initState() {
    _getCompleteTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_inProgress,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCompleteTaskList();
        },
        child: ListView.separated(
          itemCount: _completedTaskListController.completedTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskModel: _completedTaskListController.completedTaskList[index],
              onRefreshList: _getCompleteTaskList,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getCompleteTaskList() async {
    final bool result = await _completedTaskListController
        .getCompletedTaskList();
    if (!result) {
      showSnackBar(context, _completedTaskListController.errorMessage!, true);
    }
  }
}
