import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:good_habit_app/model/habit_model.dart';
import 'package:good_habit_app/screens/habit_form_screen.dart';
import 'package:provider/provider.dart';
import '../service/habit_service.dart';
import '../utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HabitService _taskService = HabitService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              Gap(30),
              // Text("Crud op of habits will be shown"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gap(20),
                  //to add
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 2.7, color: Colors.white),
                    ),
                    child: IconButton(
                        onPressed: () {
                          // Fluttertoast.showToast(
                          //     msg: "Add..",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     textColor: Colors.grey,
                          //     fontSize: 16.0);

                          //
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HabitFormScreen()));
                        },
                        icon: Icon(Icons.add)),
                  ),

                  //to edit
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 2.7, color: Colors.white),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Edit..",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                  //to delete
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 2.7, color: Colors.white),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Delete..",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        icon: Icon(Icons.delete)),
                  ),
                  //to save
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 2.7, color: Colors.white),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Save..",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        icon: Icon(Icons.save)),
                  ),
                ],
              ),
              Gap(40),
              Text("List of Habits"),

              StreamProvider<List<HabitModel>>.value(
                value: _taskService.getTasks(),
                initialData: [],
                child: Consumer<List<HabitModel>>(
                  builder: (context, tasks, child) {
                    if (tasks.isEmpty) {
                      return Center(child: Text('No tasks found'));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return ListTile(
                            title:
                                Text(task.habitTitle?.toString() ?? 'No title'),
                            trailing: IconButton(
                              icon: Icon(Icons.note_add),
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
