import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/new_taskList_controller.dart';
import 'package:task_manager/controller/task_status_count_controller.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackBar_message.dart';
import '../widgets/task_card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  static const String name = '/NewTaskScreen';

  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();
  final TaskStatusCountController _taskStatusCountController =
      Get.find<TaskStatusCountController>();

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
                },
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          GetBuilder<TaskStatusCountController>(builder: (tasCountController) {
        return Visibility(
          visible: !tasCountController.inProgress,
          replacement: const CenterCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: _taskStatusCountController.getTaskSummaryCardList),
          ),
        );
      }),
    );
  }

  Future<void> _getTaskStatusCount() async {
    final bool result =
        await _taskStatusCountController.taskStatusCountController();
    if (!result) {
      showSnackBar(context, _newTaskListController.errorMessage!, true);
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
    } else {}
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
