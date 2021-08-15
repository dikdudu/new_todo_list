import 'package:flutter/material.dart';
import 'package:todo_list/app/modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo List",
      home: SplashPage(),
    );
  }
}
