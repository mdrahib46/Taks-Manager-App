import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/addNewTask_controller.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackBar_message.dart';
import 'package:task_manager/widgets/tm_appbar.dart';
import 'new_task_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  static const String name = "/AddNewTaskScreen";

  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTeController =
  TextEditingController();
  final AddNewTaskController _addNewTaskController =
  Get.find<AddNewTaskController>();
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
                  style: Theme
                      .of(context)
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
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
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
          GetBuilder<AddNewTaskController>(builder: (addNewTaskController) {
            return Visibility(
              visible: !addNewTaskController.inProgress,
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
            );
          }),
        ],
      ),
    );
  }

  Future<void> _addNewTaskList() async {
    final bool result = await _addNewTaskController.getCreateNewTaskController(
      _titleTEController.text.trim(),
      _descriptionTeController.text.trim(),
    );

    if (result) {
      _shouldRefreshPreviousPage = true;
      showSnackBar(context, "New task has been added successfully");
      // Get.to(NewTaskScreen.name);
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     message: 'New task has been added successfully',
      //     backgroundColor: Colors.green,
      //     duration: Duration(seconds: 2),
      //   ),
      // );

    } else {
      showSnackBar(context, _addNewTaskController.errorMessage!, true);
    }
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTaskList();
    }
  }

  void _clearData() {
    _titleTEController.clear();
    _descriptionTeController.clear();
    super.context;
  }
}
