import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class TodoLogo extends StatelessWidget {
  TodoLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/logo.png",
          height: 200,
        ),
        Text('Todo List', style: context.textTheme.headline6),
      ],
    );
  }
}
