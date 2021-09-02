import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>((controller) => controller.filterSelected == TaskFilterEnum.week),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'TASK\'S DA SEMANA',
            style: context.titleStyle,
          ),
          SizedBox(height: 10),
          Container(
            height: 95,
            child: DatePicker(
              DateTime.now(),
              locale: 'pt_BR',
              initialSelectedDate: DateTime.now(),
              selectionColor: context.primaryColor,
              selectedTextColor: Colors.white,
              daysCount: 7,
              monthTextStyle: TextStyle(fontSize: 8),
              dayTextStyle: TextStyle(fontSize: 13),
              dateTextStyle: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
