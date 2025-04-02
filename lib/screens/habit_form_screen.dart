import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_habit_app/model/habit_model.dart';

import '../service/habit_service.dart';
import '../utils/app_styles.dart';

class HabitFormScreen extends StatefulWidget {
  const HabitFormScreen({super.key});

  @override
  State<HabitFormScreen> createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends State<HabitFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late User _currentUser;
  final HabitService _taskService = HabitService();
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
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                //task title
                const Text("Create your task ",
                    style: TextStyle(color: Colors.white)),
                const Gap(7),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Task Title'),
                  onSaved: (value) => _taskTitle = value,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a task title' : null,
                ),
                const Gap(7),
                //period of time for Single Completion is measuerd over.
                const Text(
                  "Period of time for Single Completion is measuerd over.",
                  style: TextStyle(color: Colors.white),
                ),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: '', hintText: "Select"),
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
                const Gap(7),
                //Goal
                const Text("Goal", style: TextStyle(color: Colors.white)),

                TextFormField(
                  decoration: const InputDecoration(labelText: ''),
                  onSaved: (value) => _goal = value,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a goal' : null,
                ),

                //task days
                const Text("Task Days", style: TextStyle(color: Colors.white)),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Task Days to Perform'),
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
                  child: const Text('Save Task'),
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

      HabitModel taskModel = HabitModel(
        habitTitle: _taskTitle,
        periodForHabitCompletion: _periodForTaskCompletion,
        goal: _goal,
        habitDaysToPerform: _taskDaysToPerform,
      );
      await _taskService.createTask(taskModel);
      Navigator.pop(context);
    }
  }
}
