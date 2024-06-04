class TaskModel {
  //fields
  String? taskId;
  String? taskTitle;
  String? periodForTaskCompletion;
  String? goal;
  String? taskDaysToPerform;

  // String? notification_for_task;

  //named parameter constructor
  TaskModel({
    this.taskId,
    this.taskTitle,
    this.periodForTaskCompletion,
    this.goal,
    this.taskDaysToPerform,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskTitle': taskTitle,
      'periodForTaskCompletion': periodForTaskCompletion,
      'goal': goal,
      'taskDaysToPerform': taskDaysToPerform,
      // 'notificationForTask': ,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map, String uid) {
    return TaskModel(
      taskId: uid,
      taskTitle: map['taskTitle'],
      periodForTaskCompletion: map['periodForTaskCompletion'],
      goal: map['goal'],
      taskDaysToPerform: map['taskDaysToPerform'],
      // notificationForTask: map['notificationForTask'],
    );
  }
}
