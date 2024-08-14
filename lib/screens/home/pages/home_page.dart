import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:kdan_task/provider/task/task_provider.dart';
import 'package:kdan_task/routes/routes_name.dart';
import '../../common/widget/display_list_of_tasks.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static HomePage builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const HomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskPageProvider = ref.watch(taskNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Upcoming Task',
              ),
              DisplayListOfTasks(
                tasks: taskPageProvider.upcomingTaskList,
                onEditTask: (task) {
                  context.push(RoutesName.createTask, extra: task);
                },
                onDeleteTask: (taskId) {
                  ref
                      .read(taskNotifierProvider.notifier)
                      .deleteTask(taskId);
                },
              ),
              const Gap(20),
              const Text(
                'Overdue Task',
              ),
              const Gap(20),
              DisplayListOfTasks(
                isOverdueTasks: true,
                tasks: taskPageProvider.overDueTaskList,
                onEditTask: (task) {
                  context.push(RoutesName.createTask, extra: task);
                },
                onDeleteTask: (taskId) {
                  ref
                      .read(taskNotifierProvider.notifier)
                      .deleteTask(taskId);
                },
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () => context.push(RoutesName.createTask),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Add New Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
