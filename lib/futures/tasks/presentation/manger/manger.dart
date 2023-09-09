import 'package:get/get.dart';
import 'package:todo_app_clean/core/errors/faliures.dart';
import 'package:todo_app_clean/futures/tasks/domain/intites/task_inity.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/add_task.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/create_database.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/delete_task.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/get_all_tasks.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/update_task.dart';

class Manger extends GetxController {
  final CreateDatabaseUseCase createDatabaseUsecase;
  final GetAllTasksUseCase getAllTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  final DeleteTaskUseCase deleteTaskUseCase;
  bool loadingCG = false;
  String? message;
  List<TaskIn> tasks = [];

  Manger(this.getAllTasksUseCase, this.createDatabaseUsecase,
      this.addTaskUseCase, this.updateTaskUseCase, this.deleteTaskUseCase);

  Future getAllTasks() async {
    final tasksOrFaliure = await getAllTasksUseCase();
    return tasksOrFaliure.fold((faliure) {
      message = _faliureToMessage(faliure);
      update();
    }, (taskss) {
      tasks = taskss;

      message = null;
      update();
    });
  }

  void getAllTasksWithCreateDatabase() async {
    loadingCG = true;
    update();
    await createDatabaseUsecase();
    final tasksOrFaliure = await getAllTasksUseCase();
    return tasksOrFaliure.fold((faliure) {
      loadingCG = false;

      message = _faliureToMessage(faliure);
      update();
    }, (taskss) {
      tasks = taskss;
      loadingCG = false;

      message = null;
      update();
    });
  }

  void checkMark(TaskIn task) async {
    final doneOrFaliure = await updateTaskUseCase(TaskIn(
      task.title,
      task.project,
      task.important,
      task.id,
      task.isCheck == "false" ? "true" : "false",
    ));
    doneOrFaliure.fold((faliure) {}, (_) async {
      await getAllTasks();
    });
  }

  Future<String?> addTask(TaskIn task) async {
    final doneOrFaliure = await addTaskUseCase(task);
    return doneOrFaliure.fold((faliure) {
      return _faliureToMessage(faliure);
    }, (_) async {
      await getAllTasks();
      Get.back();
      return null;
    });
  }

  Future<String?> deleteTask(int id) async {
    final doneOrFaliure = await deleteTaskUseCase(id);
    doneOrFaliure.fold((faliure) {
      return _faliureToMessage(faliure);
    }, (_) async {
      await getAllTasks();
      return null;
    });
    return null;
  }

  _faliureToMessage(Faliure faliure) {
    switch (faliure.runtimeType) {
      case EmptyCacheFaliure:
        return "للأسف لا يوجد مهام";

      case ServerFaliure:
        return "Something error with your server";

      default:
        return "Unexcepted Error, Please try again later";
    }
  }
}
