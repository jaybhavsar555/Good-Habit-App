import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../model/task_model.dart';
import '../../../../screens/task_form_screen.dart';
import '../../../../service/task_service.dart';
import '../../../../utils/constants/app_styles.dart';
import '../widgets/habit_actions_btn.dart';

class HabitHomePage extends StatefulWidget {
  const HabitHomePage({super.key});

  @override
  State<HabitHomePage> createState() => _HabitHomePageState();
}

class _HabitHomePageState extends State<HabitHomePage> {
  final TaskService _taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              const Gap(30),
              //habit operation btn
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HabitActionBtn(
                    icon: Icons.add,
                    toolTip: "Add",
                    onPressed: () {},
                  ),
                  HabitActionBtn(
                    icon: Icons.edit,
                    toolTip: "Edit",
                    onPressed: () {},
                  ),
                  HabitActionBtn(
                    icon: Icons.delete,
                    toolTip: "Delete",
                    onPressed: () {},
                  ),
                  HabitActionBtn(
                    icon: Icons.save,
                    toolTip: "Save",
                    onPressed: () {},
                  ),
                ],
              ),
              const Gap(40),
              const Text("List of Habits"),

              StreamProvider<List<TaskModel>>.value(
                value: _taskService.getTasks(),
                initialData: [],
                child: Consumer<List<TaskModel>>(
                  builder: (context, tasks, child) {
                    if (tasks.isEmpty) {
                      return const Center(child: Text('No tasks found'));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return ListTile(
                            title:
                                Text(task.taskTitle?.toString() ?? 'No title'),
                            trailing: IconButton(
                              icon: const Icon(Icons.note_add),
                              onPressed: () {
                                // Handle note creation
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
              // Container()
            ],
          ),
        ));
  }
}
