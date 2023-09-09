import 'package:todo_app_clean/futures/tasks/domain/intites/task_inity.dart';

class TaskModel extends TaskIn {
  const TaskModel(
      super.title, super.description, super.important, super.id, super.isCheck);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      json["title"],
      json["project"],
      json["important"],
      json["id"],
      json["isCheck"],
    );
  }
}
