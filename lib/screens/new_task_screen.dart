import 'package:flutter/material.dart';
import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSummarySection(),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const TaskCard();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          )
        ],
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

  void _onTapFAB() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
  }
}
