import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/task.dart';
import '../../../routes/routes_name.dart';
import 'common_container.dart';
import 'task_tile.dart';

class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks({
    super.key,
    this.isOverdueTasks = false,
    required this.tasks,
    this.onDeleteTask,
    this.onEditTask,
  });
  final bool isOverdueTasks;
  final List<Task> tasks;

  final ValueChanged<int?>? onDeleteTask;
  final ValueChanged<Task>? onEditTask;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = MediaQuery.sizeOf(context);
    final height = deviceSize.height * 0.3;
    final emptyTasksAlert = isOverdueTasks
        ? 'There is no overdue task yet'
        : 'There is no task to todo!';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
        child: Text(
          emptyTasksAlert,
        ),
      )
          : ListView.separated(
        shrinkWrap: true,
        itemCount: tasks.length,
        padding: EdgeInsets.zero,
        itemBuilder: (ctx, index) {
          final task = tasks[index];

          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  flex: 2,
                  onPressed: (context){
                    // TODO
                    onEditTask?.call(task);
                  },
                  backgroundColor: Color(0xFF7BC043),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context){
                    onDeleteTask?.call(task.id);
                  },
                  backgroundColor: Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: InkWell(
              onTap: (){
                context.push(RoutesName.taskDetail, extra: task);
              },
              child: TaskTile(
                task: task,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          thickness: 1.5,
        ),
      ),
    );
  }
}
