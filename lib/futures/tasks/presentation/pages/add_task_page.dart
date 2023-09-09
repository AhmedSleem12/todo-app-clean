import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_app_clean/core/snackBar/snack_bar.dart';
import 'package:todo_app_clean/futures/tasks/domain/intites/task_inity.dart';
import 'package:todo_app_clean/futures/tasks/presentation/manger/manger.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  final Manger mangerController = Get.find();
  List<String> items = ["للعمل", "شخصي", "للمنزل"];
  late String dropDownValue;
  String periorityValue = "منخفض";
  @override
  void initState() {
    super.initState();
    dropDownValue = items[0];
  }

  void valid() {
    if (formKey.currentState!.validate()) {
      TaskIn task = TaskIn(
          _titleController.text, dropDownValue, periorityValue, null, "false");
      mangerController.addTask(task).then((value) {
        if (value == null) {
          SnackBarMessage().showSnackBarMessage(
              context, "تمت أضافة المهمه بنجاح", Colors.green);
        } else {
          SnackBarMessage().showSnackBarMessage(context, value, Colors.red);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 25, top: 10, bottom: 15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => Get.back(), icon: const Icon(Icons.close)),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: twoWidgetsWithSizedBox(
                    "To-Do",
                    TextFormField(
                      controller: _titleController,
                      validator: (value) => value!.isEmpty
                          ? "عنوان المهمه غير قابل ان يكون فارغ"
                          : null,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "To-Do",
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: twoWidgetsWithSizedBox(
                    "Project",
                    SizedBox(
                      height: 60,
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(15),
                            isExpanded: true,

                            onChanged: (String? value) {
                              setState(() {
                                dropDownValue = value!;
                              });
                            },
                            // Initial Value
                            value: dropDownValue,

                            // Down Arrow Icon

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                          ),
                        ),
                        // After selecting the desired option,it will
                        // change button value to selected value
                      ),
                    ),
                    height: 10,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: twoWidgetsWithSizedBox(
                    "Tags",
                    Row(
                      children: [
                        Expanded(
                          child: periorityWidget(
                            "منخفض",
                            () {
                              setState(() {
                                periorityValue = "منخفض";
                              });
                            },
                            periorityValue == "منخفض"
                                ? Colors.white
                                : const Color(0xff1771F1),
                            periorityValue == "منخفض"
                                ? const Color(0xff1771F1)
                                : const Color(0xff1771F1).withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: periorityWidget(
                            "عالي",
                            () {
                              setState(() {
                                periorityValue = "عالي";
                              });
                            },
                            periorityValue == "عالي"
                                ? Colors.white
                                : Colors.red,
                            periorityValue == "عالي"
                                ? Colors.red
                                : Colors.red.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                    height: 10,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: defualtButton(() {
                      valid();
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget twoWidgetsWithSizedBox(String header, Widget widget,
      {double? height}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(height: height ?? 0),
        widget
      ],
    );
  }

  Widget periorityWidget(String value, void Function()? tapMethod,
      Color textColor, Color backgroundColor) {
    return GestureDetector(
      onTap: tapMethod,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: backgroundColor),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 17.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget defualtButton(void Function()? tapMethod) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(const Color(0xff1771F1)),
      ),
      onPressed: tapMethod,
      child: const Text(
        "أضافة المهمه",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}
