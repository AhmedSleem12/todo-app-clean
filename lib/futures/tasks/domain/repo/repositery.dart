import 'package:dartz/dartz.dart';
import 'package:todo_app_clean/core/errors/faliures.dart';
import 'package:todo_app_clean/futures/tasks/domain/intites/task_inity.dart';

abstract class TaskRepositery {
  Future<Either<Faliure, Unit>> createDatabase();
  Future<Either<Faliure, List<TaskIn>>> getAllTasks();
  Future<Either<Faliure, Unit>> addTask(TaskIn task);
  Future<Either<Faliure, Unit>> updateTask(TaskIn task);
  Future<Either<Faliure, Unit>> deleteTask(int taskId);
}
