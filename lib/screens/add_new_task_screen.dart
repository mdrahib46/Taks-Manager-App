import 'package:flutter/material.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackbar_message.dart';
import 'package:task_manager/widgets/tm_appbar.dart';
import '../data/utils/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  bool _inProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTeController =
      TextEditingController();

  bool _shouldRefreshPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        
        Navigator.pop(context, _shouldRefreshPreviousPage);
      },
      child: Scaffold(
        appBar: const TMAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 42),
                Text(
                  'Add New Task',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildAddNewTaskSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddNewTaskSection(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleTEController,
            decoration: const InputDecoration(hintText: 'Title'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter task title';
              }
              return null;
            },
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _descriptionTeController,
            decoration: const InputDecoration(hintText: 'Description'),
            maxLines: 10,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value!.isEmpty ?? true) {
                return "Enter task description";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: !_inProgress,
            replacement: const Center(
              child: CenterCircularProgressIndicator(),
            ),
            child: ElevatedButton(
              onPressed: () {
                _onTapSubmitButton();
              },
              child: const Icon(
                Icons.arrow_circle_right_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addNewTaskList() async {
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTeController.text.trim(),
      "status": "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestBody);
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _shouldRefreshPreviousPage = true;
      _clearTextField();
      showSnackBar(context, "New task has been added successfully");

    } else {
      showSnackBar(context, "New task add failed....!", true);
    }
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTaskList();
    }
  }

  void _clearTextField() {
    _titleTEController.clear();
    _descriptionTeController.clear();
  }
}
