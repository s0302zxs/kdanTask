import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/failure/failure.dart';
import '../../domain/entities/task.dart';
import '../../domain/repo/task_repository.dart';
import '../../utils/DateTimeHelper.dart';
import '../../utils/guard_state_notifier.dart';
import '../../utils/task_category.dart';
import '../global_loading_provider.dart';
import 'task_state.dart';

final taskNotifierProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  final globalLoadingNotifier = ref.watch(globalLoadingProvider.notifier);
  return TaskNotifier(taskRepository, globalLoadingNotifier)..getAllTasks();
});

class TaskNotifier extends GuardStateNotifier<TaskState> {
  TaskNotifier(this.taskRepository, this.globalLoadingNotifier) : super(const TaskState.initial());

  final TaskRepository taskRepository;
  final GlobalLoadingNotifier globalLoadingNotifier;

  Future<void> getAllTasks() async {
    await guard(() async {
      final taskList = await taskRepository.getAllTasks();

      final upComingTask = _getUpcomingTask(taskList);
      final overDueTask = _getOverdueTask(taskList);

      state = state.copyWith(
        homeConcreteState: TaskConcreteState.loadedData,
        upcomingTaskList: upComingTask,
        overDueTaskList: overDueTask,
      );

      return state;
    }, handleFailure: (Failure failure) {
      // TODO : Error handling
      // set state to error and update UI
      return null;
    });

  }

  Future<void> addTask(String title, String note, TimeOfDay time, DateTime date, TaskCategory taskCategory) async {
    globalLoadingNotifier.showLoading();
    await guard(() async {
      final task = Task(
        title: title,
        category: taskCategory,
        time: DateTimeHelpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        note: note,
        isCompleted: false,);

      await taskRepository.addTask(task);
      getAllTasks();

      return state;
    }, handleFailure: (Failure failure) {
      // TODO : Error handling
      return null;
    });
    globalLoadingNotifier.hideLoading();

  }

  Future<void> deleteTask(int? taskId) async {
    await guard(() async {
      await taskRepository.deleteTask(taskId);
      getAllTasks();
      return state;
    }, handleFailure: (Failure failure) {
      // TODO : Error handling
      return null;
    });
  }

  Future<void> updateTask(Task task) async {
    await guard(() async {
      await taskRepository.updateTask(task);
      getAllTasks();
      return state;
    }, handleFailure: (Failure failure) {
      // TODO : Error handling
      return null;
    });
  }

  List<Task> _getOverdueTask(List<Task> tasks) {
    final List<Task> filteredTask = [];

    for (var task in tasks) {
        final isTaskDay = DateTimeHelpers.isTaskBeforeDate(task, DateTime.now());
        if (isTaskDay) {
          filteredTask.add(task);
        }
    }
    return filteredTask;
  }

  List<Task> _getUpcomingTask(List<Task> tasks) {
    final List<Task> filteredTask = [];

    for (var task in tasks) {
      final isTaskDay = DateTimeHelpers.isTaskBeforeDate(task, DateTime.now());
      if (!isTaskDay) {
        filteredTask.add(task);
      }
    }
    return filteredTask;
  }

}
