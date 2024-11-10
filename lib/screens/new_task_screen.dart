import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/new_taskList_controller.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/models/task_status_model.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackBar_message.dart';
import '../data/utils/urls.dart';
import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  static const String name = '/NewTaskScreen';

  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _taskStatusCountListInProgress = false;
  List<TaskStatusModel> _taskStatusCountList = [];
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();

  @override
  void initState() {
    _getNewTaskList();
    _getTaskStatusCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTaskList();
          _getTaskStatusCount();
        },
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: GetBuilder<NewTaskListController>(
                  builder: (newTaskListController) {
                return Visibility(
                  visible: !newTaskListController.inProgress,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ListView.separated(
                    itemCount: newTaskListController.taskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        onRefreshList: _getNewTaskList,
                        taskModel: newTaskListController.taskList[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                  ),
                );
              }),
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

  List<TaskSummaryCard> _getTaskSummaryCardList() {
    List<TaskSummaryCard> taskSummaryCardList = [];
    for (TaskStatusModel t in _taskStatusCountList) {
      taskSummaryCardList
          .add(TaskSummaryCard(title: t.sId!, count: t.sum ?? 0));
    }
    return taskSummaryCardList;
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: _taskStatusCountListInProgress == false,
        replacement: const CenterCircularProgressIndicator(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: _getTaskSummaryCardList()),
        ),
      ),
    );
  }

  Future<void> _getTaskStatusCount() async {
    _taskStatusCountList.clear();
    _taskStatusCountListInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCount);
    _taskStatusCountListInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountListInProgress = false;
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackBar(context, response.errorMessage, true);
      setState(() {});
    }
  }

  Future<void> _getNewTaskList() async {
    final bool result = await _newTaskListController.getNewTaskList();
    if (result == false) {
      showSnackBar(
        context,
        _newTaskListController.errorMessage!,
        true,
      );
    }
  }

  void _onTapFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }
}
