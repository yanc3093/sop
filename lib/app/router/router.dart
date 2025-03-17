import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sop/app/module/sop/screen/sop_screen.dart';

abstract class Routes {
  static const String sopScreen = "/";
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.sopScreen,
      name: Routes.sopScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const SopScreen();
      },
    ),
  ],
);
