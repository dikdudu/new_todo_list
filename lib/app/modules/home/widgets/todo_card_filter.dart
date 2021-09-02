import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/total_task_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTaskModel? totalTaskModel;
  final bool selected;

  const TodoCardFilter({
    Key? key,
    required this.label,
    required this.taskFilter,
    this.totalTaskModel,
    required this.selected,
  }) : super(key: key);

  double _getPercentFinish() {
    final total = totalTaskModel?.totalTasks ?? 0.0;
    final totalFinish = totalTaskModel?.totalTasksFinish ?? 0.1;

    if (total == 0) {
      return 0.0;
    }

    final percent = (totalFinish * 100) / total;

    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: () => context.read<HomeController>().findTasks(filter: taskFilter),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 50,
            maxWidth: 140,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: selected ? context.primaryColor : Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey.withOpacity(.8),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${totalTaskModel?.totalTasks} TASKS',
                style: context.titleStyle.copyWith(
                  fontSize: 10,
                  color: selected ? Colors.white : Colors.grey,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(
                  begin: 0.0,
                  end: _getPercentFinish(),
                ),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    backgroundColor: selected ? context.primaryColorLigth : Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(selected ? Colors.white : context.primaryColor),
                    value: value,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
