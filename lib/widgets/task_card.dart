import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/deleteTaskController.dart';
import 'package:task_manager/controller/taskStatus_controller.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackBar_message.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedState = ' ';
  final UpdateTaskStatusController _updateTaskStatusController =
      Get.find<UpdateTaskStatusController>();
  final DeleteTaskController _deleteTaskController =
      Get.find<DeleteTaskController>();

  @override
  void initState() {
    _selectedState = widget.taskModel.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: Theme.of(context).textTheme.titleMedium,
              widget.taskModel.title ?? '',
            ),
            Text(widget.taskModel.description ?? ''),
            Text('Date : ${widget.taskModel.createdDate}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTaskChip(),
                Wrap(
                  children: [
                    GetBuilder<UpdateTaskStatusController>(
                        builder: (taskStatusController) {
                      return Visibility(
                        visible: !taskStatusController.inProgress,
                        replacement: const CenterCircularProgressIndicator(),
                        child: IconButton(
                            onPressed: _onTapEditButton,
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            )),
                      );
                    }),
                    GetBuilder<DeleteTaskController>(builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        replacement: const Center(
                          child: CenterCircularProgressIndicator(),
                        ),
                        child: IconButton(
                          onPressed: _onTapDeleteButton,
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      );
                    }),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onTapDeleteButton() {
    _deleteTask();
    setState(() {});
  }

  void _onTapEditButton() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: ["New", "Completed", "Canceled", "inProgress"].map((e) {
                return ListTile(
                  onTap: () {
                    _changeTaskStatus(e);
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  title: Text(e),
                  selected: _selectedState == e,
                  trailing:
                      _selectedState == e ? const Icon(Icons.check) : null,
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }

  Future<void> _changeTaskStatus(String newStatus) async {
    // _changeStatusInProgress = true;
    // setState(() {});
    // final NetworkResponse response = await NetworkCaller.getRequest(
    //     url: Urls.updateTaskStatus(widget.taskModel.sId!, newStatus));
    // _changeStatusInProgress = false;
    // setState(() {});
    // if (response.isSuccess) {
    //   widget.onRefreshList;
    //   showSnackBar(context, "Successful....!");
    //   setState(() {});
    // } else {
    //   _changeStatusInProgress = false;
    //   setState(() {});
    //   showSnackBar(context, response.errorMessage, true);
    // }

    final bool result = await _updateTaskStatusController
        .getUpdateTaskStatusController(widget.taskModel.sId!, newStatus);
    if (result) {
      widget.onRefreshList();
      showSnackBar(context, 'Task status has been changed !');
    } else {
      showSnackBar(context, _updateTaskStatusController.errorMessage!, true);
    }
  }

  // Future<void> _deleteTask() async {
  //   _deleteTaskInProgress = true;
  //   setState(() {});
  //
  //   final NetworkResponse response = await NetworkCaller.getRequest(
  //       url: Urls.deleteTaskList(widget.taskModel.sId!));
  //   _deleteTaskInProgress = false;
  //   setState(() {});
  //   if (response.isSuccess) {
  //     widget.onRefreshList();
  //     showSnackBar(context, 'Task has been deleted');
  //     setState(() {});
  //   } else {
  //     _deleteTaskInProgress = false;
  //     showSnackBar(context, response.errorMessage, true);
  //     setState(() {});
  //   }
  //
  // }

  Future<void> _deleteTask() async {
    final bool result =
        await _deleteTaskController.getDeleteTask(widget.taskModel.sId!);
    if (result) {
      widget.onRefreshList();
    } else {
      showSnackBar(context,
          _deleteTaskController.errorMessage ?? 'Delete Task Failed', true);
    }
  }

  Widget buildTaskChip() {
    return Chip(
      label: Text(
        widget.taskModel.status ?? '',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.green,
        ),
      ),
    );
  }
}
