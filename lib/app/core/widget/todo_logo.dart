import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class TodoLogo extends StatelessWidget {
  TodoLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/logo2.png",
          height: 100,
        ),
        Text('Tarefas e Despesas', style: context.textTheme.headline6),
      ],
    );
  }
}
