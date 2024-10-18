import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {

  List<TaskModel> _canceledTaskList = [];

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      itemCount: _canceledTaskList.length,
      itemBuilder: (context, index) {
        return  TaskCard(taskModel: _canceledTaskList[index],);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
