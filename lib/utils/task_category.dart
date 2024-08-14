import 'package:flutter/material.dart';

enum TaskCategory {
  life(Icons.house, Colors.blueGrey),
  health(Icons.favorite, Colors.orange),
  work(Icons.local_post_office, Colors.green),
  others(Icons.devices_other, Colors.red),;

  static TaskCategory stringToTaskCategory(String name) {
    try {
      return TaskCategory.values.firstWhere(
            (category) => category.name == name,
      );
    } catch (e) {
      return TaskCategory.others;
    }
  }

  final IconData icon;
  final Color color;
  const TaskCategory(this.icon, this.color);
}
