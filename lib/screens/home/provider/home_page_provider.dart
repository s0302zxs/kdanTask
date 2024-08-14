import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kdan_task/domain/repo/task_repository.dart';

import '../../../utils/guard_state_notifier.dart';
import 'home_state.dart';


final homePageNotifierProvider = StateNotifierProvider<HomePageNotifier, HomeState>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return HomePageNotifier(taskRepository,);
});

class HomePageNotifier extends GuardStateNotifier<HomeState> {
  HomePageNotifier(this.taskRepository,) : super(const HomeState.initial());

  final TaskRepository taskRepository;

  // TODO : could safe Home Data id need

}
