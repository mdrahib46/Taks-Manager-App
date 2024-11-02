import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/widgets/snackBar_message.dart';

import '../data/Service/network_caller.dart';
import '../widgets/task_card.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _inProgress = false;
  List<TaskModel> _inProgressTaskList = [];

  @override
  void initState() {
    _getInProgressTaskList();
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: !_inProgress,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: RefreshIndicator(
        onRefresh: () async{
          _getInProgressTaskList();
        },
        child: ListView.separated(
          itemCount: _inProgressTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(taskModel: _inProgressTaskList[index], onRefreshList: _getInProgressTaskList,);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }
  
  Future<void> _getInProgressTaskList()async{
    _inProgressTaskList.clear();
    _inProgress = true;
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.inProgressTaskList);
    _inProgress = false;
    setState(() {

    });
    if(response.isSuccess){
      final TaskListModel _taskListModel = TaskListModel.fromJson(response.responseData);
      _inProgressTaskList = _taskListModel.taskList ?? [];
    }
    else{
      showSnackBar(context, response.errorMessage, true);
    }
  }
}
