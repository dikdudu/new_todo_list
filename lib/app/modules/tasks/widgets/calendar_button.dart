import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.today,
            color: Colors.grey,
          ),
          SizedBox(width: 10),
          Text(
            'Selecione uma data',
            style: context.titleStyle,
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
