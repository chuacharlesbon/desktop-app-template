import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myadmin/cubits/my_app_cubit/my_app_cubit.dart';
import 'package:myadmin/routes/route_names.dart';
import 'package:window_manager/window_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.title});

  final String? title;

  @override
  State<LoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {

  void initData() {
    log("Initialize Login screen");
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

  @override
  Widget build(BuildContext context) {
    final myAppCubit = GetIt.instance<MyAppCubit>();
    return BlocBuilder<MyAppCubit, MyAppState>(
      bloc: myAppCubit,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.deepPurple.withOpacity(0.2),
                child: GestureDetector(
                  onTap: () {
                    GetIt.instance<GoRouter>().goNamed(Routes.home.name);
                  },
                  child: const Text(
                    'Login'
                  ),
                )
              ),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          await windowManager.destroy();
                        },
                        child: const Tooltip(
                          message: "Close this window",
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.cancel_sharp,
                              color: Colors.red
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        );
      }
    );
  }
}