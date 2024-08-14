import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kdan_task/domain/entities/task.dart';
import 'package:kdan_task/screens/home/pages/home_page.dart';
import 'package:kdan_task/screens/task_detail/pages/task_detail_page.dart';

import '../screens/create_task/pages/create_task_page.dart';
import 'routes_name.dart';

final navigationKey = GlobalKey<NavigatorState>();

final routesProvider = Provider<GoRouter>(
      (ref) {
    return GoRouter(
      initialLocation: RoutesName.home,
      navigatorKey: navigationKey,
      routes: kdanAppRoutes,
    );
  },
);

// TODO : maybe separate to another file
final kdanAppRoutes = [
  GoRoute(
    path: RoutesName.home,
    parentNavigatorKey: navigationKey,
    builder: HomePage.builder,
  ),
  GoRoute(
    path: RoutesName.createTask,
    parentNavigatorKey: navigationKey,
    builder: (context, state) {
      Task? task = state.extra as Task?;
      return CreateTaskPage.builder(context, state, task);
    },
  ),
  // GoRoute(
  //   path: RoutesName.taskList,
  //   parentNavigatorKey: navigationKey,
  //   builder: CreateTaskScreen.builder,
  // ),
  GoRoute(
    path: RoutesName.taskDetail,
    parentNavigatorKey: navigationKey,
    builder: (context, state) {
      Task task = state.extra as Task;
      return TaskDetailPage.builder(context, state, task);
    },
    // builder: TaskDetailPage.builder,
  ),
];
