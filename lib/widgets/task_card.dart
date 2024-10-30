import 'package:flutter/material.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/widgets/snackbar_message.dart';

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
  bool _changeStatusInProgress = false;

  @override
  void initState() {
    _selectedState = widget.taskModel.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
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
                    Visibility(
                      visible: _changeStatusInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: IconButton(
                          onPressed: _onTapEditButton,
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          )),
                    ),
                    IconButton(
                      onPressed: _onTapDeleteButton,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onTapDeleteButton() {}

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
                    Navigator.pop(context);
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
    _changeStatusInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.updateTaskStatus(widget.taskModel.sId!, newStatus));
    _changeStatusInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      widget.onRefreshList;
      setState(() {});
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      showSnackBar(context, response.errorMessage, true);
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
