import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/task.dart';
import '../../common/widget/circle_container.dart';

class TaskDetailPage extends ConsumerWidget {
  const TaskDetailPage({super.key, required this.task});

  final Task task;

  static TaskDetailPage builder(
    BuildContext context,
    GoRouterState state,
    Task task,
  ) => TaskDetailPage(task: task);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail'),),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleContainer(
              color: task.category.color.withOpacity(0.3),
              child: Icon(
                task.category.icon,
                color: task.category.color,
              ),
            ),
            const Gap(16),
            Text(
              task.title,
            ),
            Text(
              task.time,
            ),
            const Gap(16),
            Visibility(
              visible: !task.isCompleted,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Task to be completed on '),
                  Text(task.date),
                  Icon(
                    Icons.check_box,
                    color: task.category.color,
                  ),
                ],
              ),
            ),
            const Gap(16),
            Divider(
              color: task.category.color,
              thickness: 1.5,
            ),
            const Gap(16),
            Text(
              task.note.isEmpty
                  ? 'There is no additional note for this task'
                  : task.note,
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            // TODO 
            Visibility(
              visible: task.isCompleted,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Task Completed'),
                  Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
