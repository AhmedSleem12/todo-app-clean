import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_clean/core/errors/exceptions.dart';
import 'package:todo_app_clean/futures/tasks/data/models/task_model.dart';

abstract class LocalDataSource {
  Future<Unit> cacheData(TaskModel task);
  Future<Unit> createDataBase();
  Future<List<TaskModel>> getCached();
  Future<Unit> deleteTask(int taskId);
  Future<Unit> updateTask(TaskModel task);
}

class LocalDataSourceImpl implements LocalDataSource {
  Database? database;

  @override
  Future<Unit> cacheData(TaskModel task) async {
    await database!.rawInsert(
        'INSERT INTO tasks (title , project , important , isCheck) VALUES("${task.title.replaceAll(")", "").replaceAll("(", "").replaceAll("\"", "")}" , "${task.project.replaceAll(")", "").replaceAll("(", "").replaceAll("\"", "")}" , "${task.important}" , "${task.isCheck}")');

    return Future.value(unit);
  }

  @override
  Future<Unit> createDataBase() async {
    database = await openDatabase("tasks.db", version: 1,
        onCreate: (database, version) async {
      await database.execute(
        "CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , project TEXT , important TEXT , isCheck TEXT)",
      );
      // ignore: avoid_print
      print("database created");
      // ignore: avoid_print
      print("Table Created");
    }, onOpen: (database) {});

    // ignore: avoid_print
    return Future.value(unit);
  }

  @override
  Future<List<TaskModel>> getCached() async {
    List<TaskModel> bigData = [];
    final data = await database!.rawQuery("SELECT * FROM tasks");
    bigData = data.map<TaskModel>((e) => TaskModel.fromJson(e)).toList();

    if (bigData.isNotEmpty) {
      return bigData;
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> deleteTask(int taskId) async {
    await database!.rawDelete("DELETE FROM tasks WHERE id = ?", [taskId]);
    return Future.value(unit);
  }

  @override
  Future<Unit> updateTask(TaskModel task) async {
    await database!.rawUpdate(
      "UPDATE tasks SET title = ? , project = ? , important = ? , isCheck = ? WHERE id = ?",
      [
        task.title,
        task.project,
        task.important,
        task.isCheck,
        task.id,
      ],
    );

    return Future.value(unit);
  }
}
