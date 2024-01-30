import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myadmin/cubits/my_app_cubit/my_app_cubit.dart';
import 'package:myadmin/routes/route_names.dart';
import 'package:myadmin/utils/theme.dart';
import 'package:window_manager/window_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.title});

  final String? title;

  @override
  State<LoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {

  TextEditingController managerCode = TextEditingController();
  FocusNode managerCodeFocus = FocusNode();
  bool isManagerCodeActive = false;

  TextEditingController password = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  bool isPasswordActive = false;

  void initData() {
    log("Initialize Login screen");
  }

  @override
  void dispose() {
    //
    super.dispose();
    managerCodeFocus.removeListener(_onManagerCodeFocusChange);
    managerCodeFocus.dispose();
    passwordFocus.removeListener(_onPasswordFocusChange);
    passwordFocus.dispose();
  }

  @override
  void initState() {
    initData();
    super.initState();
    managerCodeFocus.addListener(_onManagerCodeFocusChange);
    passwordFocus.addListener(_onPasswordFocusChange);
  }

  void _onManagerCodeFocusChange() {
    // setState(() {
    //   if(managerCodeFocus.hasFocus){
    //     isManagerCodeActive = true;
    //   }else{
    //     isManagerCodeActive = false;
    //   }
    // });
  }

  void _onPasswordFocusChange() {
    // setState(() {
    //   if(passwordFocus.hasFocus){
    //     isPasswordActive = true;
    //   }else{
    //     isPasswordActive = false;
    //   }
    // });
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
                padding: const EdgeInsets.all(50),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 400,
                                height: 100,
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    "WELCOME ADMIN!",
                                    style: MyDesktopTheme.textbody20()
                                  )
                                ),
                              ),
                              const SizedBox(height: 100),
                              SizedBox(
                                width: 400,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    FilledButton(
                                      style: FilledButton.styleFrom(
                                        fixedSize: Size(150, 50),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                      onPressed: () {
                        
                                      },
                                      child: Center(
                                          child: Text(
                                            "USER",
                                            style: MyDesktopTheme.textbody20(
                                              color: Colors.white
                                            )
                                          )
                                        )
                                    ),
                                    FilledButton(
                                      style: FilledButton.styleFrom(
                                        fixedSize: Size(150, 50),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                      onPressed: () {
                        
                                      },
                                      child: Center(
                                          child: Text(
                                            "ADMIN",
                                            style: MyDesktopTheme.textbody20(
                                              color: Colors.white
                                            )
                                          )
                                        )
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              SizedBox(
                                width: 400,
                                child: TextFormField(
                                  controller: managerCode,
                                  focusNode: managerCodeFocus,
                                  onTap: () {
                                    setState(() {
                                      isManagerCodeActive = true;
                                      isPasswordActive = false;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Manager Code"
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 400,
                                child: TextFormField(
                                  controller: password,
                                  focusNode: passwordFocus,
                                  obscureText: true,
                                  obscuringCharacter : "*",
                                  onTap: () {
                                    setState(() {
                                      isManagerCodeActive = false;
                                      isPasswordActive = true;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "PIN"
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  fixedSize: Size(400, 50),
                                  backgroundColor: Colors.redAccent,
                                ),
                                onPressed: managerCode.text.isNotEmpty && password.text.isNotEmpty
                                ? () {
                                  GetIt.instance<GoRouter>().goNamed(Routes.home.name);
                                }
                                : null,
                                child: Center(
                                    child: Text(
                                      "LOGIN",
                                      style: MyDesktopTheme.textbody20(
                                        color: Colors.white
                                      )
                                    )
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: double.infinity,
                              color: Colors.white,
                            )
                          ),
                          // KEYPAD
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: double.infinity,
                              color: Colors.grey,
                              child: Column(
                                children: [
                                  ////////////////////////////
                                  //
                                  // ROW A
                                  //
                                  ////////////////////////////
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "7";
                                                  }else if (isPasswordActive){
                                                    password.text += "7";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "7",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "8";
                                                  }else if (isPasswordActive){
                                                    password.text += "8";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "8",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "9";
                                                  }else if (isPasswordActive){
                                                    password.text += "9";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "9",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                if(isManagerCodeActive && managerCode.text.isNotEmpty){
                                                  setState(() {
                                                    managerCode.text = managerCode.text.substring(0, (managerCode.text.length - 1));
                                                  });
                                                }else if(isPasswordActive && password.text.isNotEmpty){
                                                  setState(() {
                                                    password.text = password.text.substring(0, (password.text.length - 1));
                                                  });
                                                }
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "Bck",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 20,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),

                                  ////////////////////////////
                                  //
                                  // ROW B
                                  //
                                  ////////////////////////////
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "4";
                                                  }else if (isPasswordActive){
                                                    password.text += "4";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "4",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "5";
                                                  }else if (isPasswordActive){
                                                    password.text += "5";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "5",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "6";
                                                  }else if (isPasswordActive){
                                                    password.text += "6";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "6",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "#";
                                                  }else if (isPasswordActive){
                                                    password.text += "#";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "#",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),

                                  ////////////////////////////
                                  //
                                  // ROW C
                                  //
                                  ////////////////////////////
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "1";
                                                  }else if (isPasswordActive){
                                                    password.text += "1";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "1",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "2";
                                                  }else if (isPasswordActive){
                                                    password.text += "2";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "2",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "3";
                                                  }else if (isPasswordActive){
                                                    password.text += "3";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "3",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "*";
                                                  }else if (isPasswordActive){
                                                    password.text += "*";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "*",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),

                                  ////////////////////////////
                                  //
                                  // ROW A
                                  //
                                  ////////////////////////////
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += ".";
                                                  }else if (isPasswordActive){
                                                    password.text += ".";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    ".",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "0";
                                                  }else if (isPasswordActive){
                                                    password.text += "0";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "0",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += ",";
                                                  }else if (isPasswordActive){
                                                    password.text += ",";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    ",",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                if(isManagerCodeActive){
                                                    managerCode.text += "";
                                                  }else if (isPasswordActive){
                                                    password.text += "";
                                                  }
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "Enter",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 16,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            )
                          )
                        ],
                      )
                    )
                  ],
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