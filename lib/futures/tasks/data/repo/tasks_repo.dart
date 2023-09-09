import 'package:todo_app_clean/core/errors/exceptions.dart';
import 'package:todo_app_clean/futures/tasks/data/datasources/local_data_source.dart';
import 'package:todo_app_clean/futures/tasks/data/models/task_model.dart';
import 'package:todo_app_clean/futures/tasks/domain/intites/task_inity.dart';
import 'package:todo_app_clean/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app_clean/futures/tasks/domain/repo/repositery.dart';

class TasksRepo implements TaskRepositery {
  final LocalDataSource localDataSource;

  TasksRepo(this.localDataSource);
  @override
  Future<Either<Faliure, Unit>> addTask(TaskIn task) async {
    TaskModel taskModel = TaskModel(
      task.title,
      task.project,
      task.important,
      null,
      task.isCheck,
    );
    await localDataSource.cacheData(taskModel);
    return const Right(unit);
  }

  @override
  Future<Either<Faliure, Unit>> deleteTask(int taskId) async {
    await localDataSource.deleteTask(taskId);
    return const Right(unit);
  }

  @override
  Future<Either<Faliure, Unit>> createDatabase() async {
    try {
      await localDataSource.createDataBase();
      return const Right(unit);
    } on EmptyCacheException {
      return Left(EmptyCacheFaliure());
    }
  }

  @override
  Future<Either<Faliure, Unit>> updateTask(TaskIn task) async {
    final taskModel = TaskModel(
      task.title,
      task.project,
      task.important,
      task.id,
      task.isCheck,
    );
    await localDataSource.updateTask(taskModel);

    return const Right(unit);
  }

  @override
  Future<Either<Faliure, List<TaskIn>>> getAllTasks() async {
    try {
      final data = await localDataSource.getCached();
      return Right(data);
    } on EmptyCacheException {
      return Left(EmptyCacheFaliure());
    }
  }
}
