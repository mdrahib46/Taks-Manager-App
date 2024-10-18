import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  List<TaskModel> _completedTaskModel = [];

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      itemCount: _completedTaskModel.length,
      itemBuilder: (context, index) {
        return TaskCard(taskModel: _completedTaskModel[index],);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
