import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class Routes {
  static const String tasksScreen = "/";
  static const String taskSopScreen = "/sop";
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.tasksScreen,
      name: Routes.tasksScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const TasksScreen();
      },
    ),
    GoRoute(
      path: Routes.taskSopScreen,
      name: Routes.taskSopScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const TaskSopScreen();
      },
    ),
  ],
);
