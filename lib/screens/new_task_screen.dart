import 'package:flutter/material.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackbar_message.dart';
import '../data/utils/urls.dart';
import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _inProgress = false;
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    _getNewTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          _getNewTaskList();
        },
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: Visibility(
                visible: !_inProgress,
                replacement: const CenterCircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(taskModel: _newTaskList[index],);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapFAB,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TaskSummaryCard(
              count: 9,
              title: 'new',
            ),
            TaskSummaryCard(
              count: 9,
              title: 'Completed',
            ),
            TaskSummaryCard(
              count: 9,
              title: 'Canceled',
            ),
            TaskSummaryCard(
              count: 9,
              title: 'InProgress',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _inProgress = true;
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];

    } else {
      showSnackBar(context, response.errorMessage, true);
    }
    _inProgress = false;
    setState(() {});
  }


  // Future<void> _deleteTask(String taskId) async{
  //  final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.deleteTaskList(taskId));
  //  if(response.isSuccess){
  //    TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
  //    // taskListModel.taskLis
  //
  //  }
  //
  // }


  void _onTapFAB() async{
    final bool? shouldRefresh = await Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if(shouldRefresh == true){
      _getNewTaskList();
    }
  }
}
