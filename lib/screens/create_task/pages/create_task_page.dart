import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:kdan_task/provider/task/task_provider.dart';
import 'package:kdan_task/routes/routes_name.dart';
import 'package:kdan_task/utils/task_category.dart';

import '../../../domain/entities/task.dart';
import '../../../provider/category_provider.dart';
import '../../../provider/date_provider.dart';
import '../../../provider/time_provider.dart';
import '../../common/widget/categories_selection.dart';
import '../../common/widget/common_text_field.dart';
import '../../common/widget/select_date_time.dart';
import '../provider/create_task_page_provider.dart';
import '../provider/create_task_state.dart';

class CreateTaskPage extends ConsumerStatefulWidget {

  static CreateTaskPage builder(
      BuildContext context,
      GoRouterState state,
      Task? task,
      ) => CreateTaskPage(task: task);

  const CreateTaskPage({super.key, this.task});

  final Task? task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTaskPageState();
}

class _CreateTaskPageState extends ConsumerState<CreateTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // TODO : own state to edit task
  CreateTaskState get _createTaskPageProvider => ref.watch(createTaskPageNotifierProvider);
  CreateTaskPageNotifier get _createTaskPageProviderNotifier => ref.read(createTaskPageNotifierProvider.notifier);

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task?.title ?? '';
    _noteController.text = widget.task?.note ?? '';

  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Add New Task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                hintText: 'Task Title',
                title: 'Task Title',
                controller: _titleController,
              ),
              const Gap(30),
              CategoriesSelection(),
              const Gap(30),
              SelectDateTime(date: DateTime.now(), time:  TimeOfDay.now(),),
              const Gap(30),
              CommonTextField(
                hintText: 'Notes',
                title: 'Notes',
                maxLines: 6,
                controller: _noteController,
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: (){
                  _createTask(_titleController.text.trim(), _noteController.text.trim(), ref.watch(timeProvider), ref.watch(dateProvider), ref.watch(categoryProvider));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Save',
                  ),
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask(String title, String note, TimeOfDay time, DateTime date, TaskCategory taskCategory) async {
      await ref.read(taskNotifierProvider.notifier).addTask(title, note, time, date, taskCategory).then((value) {
        context.go(RoutesName.home);
      });

  }
}
