class HabitModel {
  //fields
  String? habitId;
  String? habitTitle;
  String? periodForHabitCompletion;
  String? goal;
  String? habitDaysToPerform;

  // String? notification_for_task;

  //named parameter constructor
  HabitModel({
    this.habitId,
    this.habitTitle,
    this.periodForHabitCompletion,
    this.goal,
    this.habitDaysToPerform,
  });

  Map<String, dynamic> toMap() {
    return {
      'habitTitle': habitTitle,
      'periodForHabitCompletion': periodForHabitCompletion,
      'goal': goal,
      'habitDaysToPerform': habitDaysToPerform,
      // 'notificationForTask': ,
    };
  }

  factory HabitModel.fromMap(Map<String, dynamic> map, String uid) {
    return HabitModel(
      habitId: uid,
      habitTitle: map['habitTitle'],
      periodForHabitCompletion: map['periodForHabitCompletion'],
      goal: map['goal'],
      habitDaysToPerform: map['habitDaysToPerform'],
      // notificationForTask: map['notificationForTask'],
    );
  }
}
