import 'package:dartz/dartz.dart';
import 'package:todo_app_clean/core/errors/faliures.dart';
import 'package:todo_app_clean/futures/tasks/domain/intites/task_inity.dart';
import 'package:todo_app_clean/futures/tasks/domain/repo/repositery.dart';

class GetAllTasksUseCase {
  final TaskRepositery repositery;

  GetAllTasksUseCase(this.repositery);

  Future<Either<Faliure, List<TaskIn>>> call() async {
    return await repositery.getAllTasks();
  }
}
