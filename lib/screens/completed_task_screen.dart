import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/widgets/snackbar_message.dart';
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
  List<TaskModel> _completedTaskList = [];

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
        onRefresh: () async{
          _getCompleteTaskList();
        },
        child: ListView.separated(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskModel: _completedTaskList[index],
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
    _inProgress = true;
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.completedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _completedTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBar(context, response.errorMessage, true);
    }
    _inProgress = false;
    setState(() {});
  }
}
