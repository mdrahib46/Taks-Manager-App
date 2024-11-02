import 'package:flutter/material.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/widgets/snackBar_message.dart';

import '../widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {

  bool _inProgress = false;
  List<TaskModel> _canceledTaskList = [];

  @override
  void initState() {
    _getCanceledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_inProgress,
      replacement: const Center(child: CircularProgressIndicator(),),
      child: RefreshIndicator(
        onRefresh: () async{
          _getCanceledTaskList();
        },
        child: ListView.separated(
          itemCount: _canceledTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(taskModel: _canceledTaskList[index], onRefreshList: _getCanceledTaskList,);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getCanceledTaskList() async {
    _canceledTaskList.clear();
    _inProgress = true;
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.canceledTaskList);
    _inProgress = false;
    setState(() {

    });
    if (response.isSuccess) {
    final TaskListModel _canceledTaskModel = TaskListModel.fromJson(response.responseData);
    _canceledTaskList = _canceledTaskModel.taskList ?? [];
  }
    else{
      showSnackBar(context,response.errorMessage, true);
    }
  }

}
