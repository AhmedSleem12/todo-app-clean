import 'package:dartz/dartz.dart';
import 'package:todo_app_clean/core/errors/faliures.dart';

import 'package:todo_app_clean/futures/tasks/domain/repo/repositery.dart';

class DeleteTaskUseCase {
  final TaskRepositery repositery;

  DeleteTaskUseCase(this.repositery);

  Future<Either<Faliure, Unit>> call(int taskId) async {
    return await repositery.deleteTask(taskId);
  }
}
