import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_clean/futures/tasks/data/datasources/local_data_source.dart';
import 'package:todo_app_clean/futures/tasks/data/repo/tasks_repo.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/add_task.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/create_database.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/delete_task.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/get_all_tasks.dart';
import 'package:todo_app_clean/futures/tasks/domain/usecases/update_task.dart';
import 'package:todo_app_clean/futures/tasks/presentation/manger/manger.dart';

import 'package:todo_app_clean/futures/tasks/presentation/pages/add_task_page.dart';
import 'package:todo_app_clean/futures/tasks/presentation/widgets/home_screen_widget/loaded_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final localDatasource = LocalDataSourceImpl();

  @override
  void initState() {
    super.initState();
    Get.put(Manger(
        GetAllTasksUseCase(TasksRepo(localDatasource)),
        CreateDatabaseUseCase(TasksRepo(localDatasource)),
        AddTaskUseCase(TasksRepo(localDatasource)),
        UpdateTaskUseCase(TasksRepo(localDatasource)),
        DeleteTaskUseCase(TasksRepo(localDatasource)))
      ..getAllTasksWithCreateDatabase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(() => const AddTaskPage());
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 21, 122, 204),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
      body: GetBuilder<Manger>(
        builder: (controller) {
          return controller.loadingCG
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : controller.message == null
                  ? const LoadedWidget()
                  : Center(
                      child: Text(controller.message!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    );
        },
      ),
    );
  }
}
