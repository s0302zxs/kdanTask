import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../provider/date_provider.dart';
import '../../../provider/time_provider.dart';
import '../../../utils/DateTimeHelper.dart';
import 'common_text_field.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({
    super.key,
    required this.date,
    required this.time,
    this.onPickDate,
    this.onPickTime
  });

  final DateTime date;
  final TimeOfDay time;

  final ValueChanged<DateTime>? onPickDate;
  final ValueChanged<TimeOfDay>? onPickTime;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);

    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            title: 'Date',
            hintText: DateTimeHelpers.dateFormatter(date),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => DateTimeHelpers.selectDate(context, ref),
              icon: const Icon(Icons.calendar_month),
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: CommonTextField(
            title: 'Time',
            hintText: DateTimeHelpers.timeToString(time),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectTime(context, ref),
              icon: const Icon(Icons.lock_clock),
            ),
          ),
        ),
      ],
    );
  }

  void _selectTime(BuildContext context, WidgetRef ref) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      ref.read(timeProvider.notifier).state = pickedTime;
    }
  }
}
