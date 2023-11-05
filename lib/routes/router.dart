import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myadmin/features/Home/presentation/home_page.dart';
import 'package:myadmin/features/Login/presentation/login_page.dart';
import 'package:myadmin/routes/route_names.dart';

class MyRoutes {
  static List<RouteBase> myRoutes = [
    GoRoute(
      path: Routes.login.path,
      name: Routes.login.name,
      pageBuilder: (context, state) => const MaterialPage(
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: Routes.home.path,
      name: Routes.home.name,
      pageBuilder: (context, state) => const MaterialPage(
        child: HomePage(),
      ),
    )
  ];
}