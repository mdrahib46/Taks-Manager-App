import 'package:flutter/material.dart';

class TaskSummaryCard extends StatefulWidget {
  const TaskSummaryCard({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  State<TaskSummaryCard> createState() => _TaskSummaryCardState();
}

class _TaskSummaryCardState extends State<TaskSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '${widget.count}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              FittedBox(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}