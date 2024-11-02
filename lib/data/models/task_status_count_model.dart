import 'package:task_manager/data/models/task_status_model.dart';

class TaskStatusCountModel {
  String? status;
  List<TaskStatusModel>? taskStatusCountList;

  TaskStatusCountModel({this.status, this.taskStatusCountList});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskStatusCountList = <TaskStatusModel>[];
      json['data'].forEach((v) {
        taskStatusCountList!.add(new TaskStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.taskStatusCountList != null) {
      data['data'] = this.taskStatusCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

