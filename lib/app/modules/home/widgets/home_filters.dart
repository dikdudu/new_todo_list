import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/total_task_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: "HOJE",
                taskFilter: TaskFilterEnum.today,
                totalTaskModel:
                    context.select<HomeController, TotalTaskModel?>((controller) => controller.todayTotalTask),
                selected: context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              TodoCardFilter(
                label: "AMANHA",
                taskFilter: TaskFilterEnum.tomorrow,
                totalTaskModel:
                    context.select<HomeController, TotalTaskModel?>((controller) => controller.tomorrowTotalTask),
                selected: context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                label: "SEMANA",
                taskFilter: TaskFilterEnum.week,
                totalTaskModel:
                    context.select<HomeController, TotalTaskModel?>((controller) => controller.weekTotalTask),
                selected: context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) ==
                    TaskFilterEnum.week,
              ),
            ],
          ),
        )
      ],
    );
  }
}
