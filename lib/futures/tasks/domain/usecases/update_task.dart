import 'package:dartz/dartz.dart';
import 'package:todo_app_clean/core/errors/faliures.dart';
import 'package:todo_app_clean/futures/tasks/domain/intites/task_inity.dart';
import 'package:todo_app_clean/futures/tasks/domain/repo/repositery.dart';

class UpdateTaskUseCase {
  final TaskRepositery repositery;

  UpdateTaskUseCase(this.repositery);

  Future<Either<Faliure, Unit>> call(TaskIn task) async {
    return await repositery.updateTask(task);
  }
}
