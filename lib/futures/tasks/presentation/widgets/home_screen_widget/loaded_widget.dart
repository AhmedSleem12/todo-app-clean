import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_app_clean/core/snackBar/snack_bar.dart';

import 'package:todo_app_clean/futures/tasks/domain/intites/task_inity.dart';
import 'package:todo_app_clean/futures/tasks/presentation/manger/manger.dart';

import 'package:todo_app_clean/futures/tasks/presentation/widgets/home_screen_widget/check_box.dart';

class LoadedWidget extends StatefulWidget {
  const LoadedWidget({Key? key}) : super(key: key);

  @override
  State<LoadedWidget> createState() => _LoadedWidgetState();
}

class _LoadedWidgetState extends State<LoadedWidget> {
  final Manger mangerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 35.0, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "المهام",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GetBuilder<Manger>(
              builder: (controller) => Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    return buildItem(controller.tasks[index], () {
                      controller.checkMark(controller.tasks[index]);
                    }, () {
                      controller
                          .deleteTask(controller.tasks[index].id!)
                          .then((value) {
                        if (value == null) {
                          SnackBarMessage().showSnackBarMessage(
                              context, "المهمه حذفت بنجاح", Colors.red);
                        }
                      });
                    });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 40,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      TaskIn task, void Function()? method, void Function()? iconMethod) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 165,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckBox(isCheck: task.isCheck, method: method),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        task.project,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 40.0),
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: task.important == "عالي"
                          ? Colors.red.withOpacity(0.5)
                          : task.important == "منخفض"
                              ? Colors.blue.withOpacity(0.4)
                              : null,
                    ),
                    child: Center(
                      child: Text(
                        task.important,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: task.important == "عالي"
                              ? Colors.red
                              : task.important == "منخفض"
                                  ? Colors.blue
                                  : null,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_rounded,
                      color: Colors.black,
                    ),
                    onPressed: iconMethod,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
