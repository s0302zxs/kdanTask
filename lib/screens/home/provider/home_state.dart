import 'package:kdan_task/domain/entities/task.dart';

enum HomeConcreteState {
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

class HomeState {
  final HomeConcreteState homeConcreteState;
  final List<Task> upcomingTaskList;
  final List<Task> overDueTaskList;

  const HomeState({
    this.homeConcreteState = HomeConcreteState.initial,
    this.upcomingTaskList = const [],
    this.overDueTaskList = const [],
  });

  const HomeState.initial({
    this.homeConcreteState = HomeConcreteState.initial,
    this.upcomingTaskList = const [],
    this.overDueTaskList = const [],
  });

  HomeState copyWith({
    HomeConcreteState? homeConcreteState,
    List<Task>? upcomingTaskList,
    List<Task>? overDueTaskList,
  }) {
    return HomeState(
      homeConcreteState: homeConcreteState ?? this.homeConcreteState,
      upcomingTaskList: upcomingTaskList ?? this.upcomingTaskList,
      overDueTaskList: overDueTaskList ?? this.overDueTaskList,
    );
  }

}
