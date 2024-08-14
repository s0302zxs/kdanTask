import 'package:flutter/material.dart';
import 'package:kdan_task/utils/task_category.dart';

enum CreateTaskConcreteState {
  initial,
  loadedData,
}

class CreateTaskState {
  final CreateTaskConcreteState createTaskConcreteState;
  final DateTime date;
  final TimeOfDay time;
  final TaskCategory taskCategory;

  CreateTaskState({
    this.createTaskConcreteState = CreateTaskConcreteState.initial,
    date,
    time,
    this.taskCategory = TaskCategory.health,
  })  : date = DateTime.now(),
        time = TimeOfDay.now();

  CreateTaskState.initial({
    this.createTaskConcreteState = CreateTaskConcreteState.initial,
    date,
    time,
    this.taskCategory = TaskCategory.health,
  })  : date = DateTime.now(),
        time = TimeOfDay.now();

  CreateTaskState copyWith({
    CreateTaskConcreteState? createTaskConcreteState,
    DateTime? date,
    TimeOfDay? time,
    TaskCategory? taskCategory,
  }) {
    return CreateTaskState(
      createTaskConcreteState: createTaskConcreteState ?? this.createTaskConcreteState,
      date: date ?? this.date,
      time: time ?? this.time,
      taskCategory: taskCategory ?? this.taskCategory,
    );
  }
}
