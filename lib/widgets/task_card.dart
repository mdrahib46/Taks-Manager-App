import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
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
              'Title of the Task',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Text('Description of the Task'),
            const Text('Date : 12/03/2024'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTaskChip(),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: _onTapEditButton,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        )),
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
              children: ["New", "Completed", "Canceled", "Completed"].map((e) {
                return ListTile(
                  title: Text(e),
                );
              }).toList(),
            ),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text('Cancel')),
              TextButton(
                onPressed: () {},
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  Widget buildTaskChip() {
    return Chip(
      label: const Text(
        'New',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
