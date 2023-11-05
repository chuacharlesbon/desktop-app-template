import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myadmin/cubits/my_app_cubit/my_app_cubit.dart';

class DrawerAdmin extends StatefulWidget {
  const DrawerAdmin({super.key, this.title});

  final String? title;

  @override
  State<DrawerAdmin> createState() => _MyDrawerAdminState();
}

class _MyDrawerAdminState extends State<DrawerAdmin> {

  bool isCollapsed = false;

  void initData() {
    log("Initialize drawer component");
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

  Widget collapsedDrawer() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width >= 1536 ? 80 : 60,
      height: double.infinity,
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isCollapsed = !isCollapsed;
          });
        },
        child: const Text(
          'Drawer'
        ),
      )
    );
  }

  Widget fullDrawer() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width >= 1536 ? 300 : 250,
      height: double.infinity,
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isCollapsed = !isCollapsed;
          });
        },
        child: const Text(
          'Drawer'
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final myAppCubit = GetIt.instance<MyAppCubit>();
    return BlocBuilder<MyAppCubit, MyAppState>(
      bloc: myAppCubit,
      builder: (context, state) {
        return isCollapsed
        ? collapsedDrawer()
        : fullDrawer();
      }
    );
  }
}