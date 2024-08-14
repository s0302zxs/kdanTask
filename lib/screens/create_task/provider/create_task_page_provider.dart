import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/repo/task_repository.dart';
import '../../../utils/guard_state_notifier.dart';
import 'create_task_state.dart';

final createTaskPageNotifierProvider = StateNotifierProvider.autoDispose<CreateTaskPageNotifier, CreateTaskState>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return CreateTaskPageNotifier(taskRepository,);
});

class CreateTaskPageNotifier extends GuardStateNotifier<CreateTaskState> {
  CreateTaskPageNotifier(this.taskRepository,) : super(CreateTaskState.initial());

  final TaskRepository taskRepository;


  void setInitData(Task? task){
    state = state.copyWith(
      taskCategory: task?.category
    );
  }



}
