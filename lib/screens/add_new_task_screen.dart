import 'package:flutter/material.dart';
import 'package:task_manager/widgets/tm_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 42),
              Text(
                'Add New Task',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(height: 6),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Description'),
                maxLines: 10,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_circle_right_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
