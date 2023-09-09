import 'package:dartz/dartz.dart';
import 'package:todo_app_clean/core/errors/faliures.dart';

import 'package:todo_app_clean/futures/tasks/domain/repo/repositery.dart';

class CreateDatabaseUseCase {
  final TaskRepositery repositery;

  CreateDatabaseUseCase(this.repositery);

  Future<Either<Faliure, Unit>> call() async {
    return await repositery.createDatabase();
  }
}
