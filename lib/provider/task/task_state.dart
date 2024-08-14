import '../../domain/entities/task.dart';

enum TaskConcreteState {
  initial,
  loadedData,

  createdPost,
  createPostRetry,
  createPostError,
  generalError,
  notLogin,
  publishPostSuccess,
  publishPostError,
  tooManyPhotos,
}

class TaskState {
  final TaskConcreteState homeConcreteState;
  final List<Task> upcomingTaskList;
  final List<Task> overDueTaskList;

  const TaskState({
    this.homeConcreteState = TaskConcreteState.initial,
    this.upcomingTaskList = const [],
    this.overDueTaskList = const [],
  });

  const TaskState.initial({
    this.homeConcreteState = TaskConcreteState.initial,
    this.upcomingTaskList = const [],
    this.overDueTaskList = const [],
  });

  TaskState copyWith({
    TaskConcreteState? homeConcreteState,
    List<Task>? upcomingTaskList,
    List<Task>? overDueTaskList,
  }) {
    return TaskState(
      homeConcreteState: homeConcreteState ?? this.homeConcreteState,
      upcomingTaskList: upcomingTaskList ?? this.upcomingTaskList,
      overDueTaskList: overDueTaskList ?? this.overDueTaskList,
    );
  }

}
