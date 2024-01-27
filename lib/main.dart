import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:myadmin/cubits/init_cubit.dart';
import 'package:myadmin/cubits/my_app_cubit/my_app_cubit.dart';

import 'package:window_manager/window_manager.dart';

Future<void> initializaLocalDBHive() async {
  var path = Directory.current.path;
  Hive.init(path);
  var testDB = await Hive.openBox('testDB');
  log('Initialize testDB: ${testDB.values.toList().toString()}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    //size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setFullScreen(true);
  });

  await initializaLocalDBHive();
  initializeCubits();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void initData() {
    log("Initialize main widget");
    final myAppCubit = GetIt.instance<MyAppCubit>();
    myAppCubit.testServer();
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final serviceLocator = GetIt.instance;
    final myAppCubit = GetIt.instance<MyAppCubit>();
    return BlocBuilder<MyAppCubit, MyAppState>(
      bloc: myAppCubit,
      builder: (context, state) {
        return MaterialApp.router(
          title: 'My Admin',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: serviceLocator<GoRouter>(), //_router,
        );
      }
    );
  }
}