import 'package:flutter/material.dart';
import 'package:todo_list/app/core/widget/todo_logo.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TodoLogo(),
          ),
        ],
      ),
    );
  }
}
