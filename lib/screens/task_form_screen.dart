import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_habit_app/model/task_model.dart';

import '../service/task_service.dart';
import '../utils/app_styles.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late User _currentUser;
  final TaskService _taskService = TaskService();
  String? _taskTitle;
  String? _periodForTaskCompletion;
  String? _goal;
  String? _taskDaysToPerform;
  String? _notificationForTask;

  final List<String> _periodOptions = ['Daily', 'Weekly', 'Monthly'];
  final List<String> _daysOptions = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(30),
                //task title
                const Text("Create your task ",
                    style: TextStyle(color: Colors.white)),
                Gap(7),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Task Title'),
                  onSaved: (value) => _taskTitle = value,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a task title' : null,
                ),
                Gap(7),
                //period of time for Single Completion is measuerd over.
                const Text(
                  "Period of time for Single Completion is measuerd over.",
                  style: TextStyle(color: Colors.white),
                ),
                DropdownButtonFormField<String>(
                  decoration:
                      InputDecoration(labelText: '', hintText: "Select"),
                  items: _periodOptions.map((String period) {
                    return DropdownMenuItem<String>(
                      value: period,
                      child: Text(period),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _periodForTaskCompletion = value),
                  validator: (value) =>
                      value == null ? 'Please select a period' : null,
                ),
                Gap(7),
                //Goal
                Text("Goal", style: TextStyle(color: Colors.white)),

                TextFormField(
                  decoration: InputDecoration(labelText: ''),
                  onSaved: (value) => _goal = value,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a goal' : null,
                ),

                //task days
                Text("Task Days", style: TextStyle(color: Colors.white)),
                DropdownButtonFormField<String>(
                  decoration:
                      InputDecoration(labelText: 'Task Days to Perform'),
                  items: _daysOptions.map((String day) {
                    return DropdownMenuItem<String>(
                      value: day,
                      child: Text(day),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _taskDaysToPerform = value),
                  validator: (value) =>
                      value == null ? 'Please select a day' : null,
                ),

                ElevatedButton(
                  onPressed: () => _saveTask(),
                  child: Text('Save Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      TaskModel taskModel = TaskModel(
        taskTitle: _taskTitle,
        periodForTaskCompletion: _periodForTaskCompletion,
        goal: _goal,
        taskDaysToPerform: _taskDaysToPerform,
      );
      await _taskService.createTask(taskModel);
      Navigator.pop(context);
    }
  }
}
