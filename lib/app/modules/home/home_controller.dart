import 'package:todo_list/app/core/notifier/app_change_notifier.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/models/total_task_model.dart';
import 'package:todo_list/app/models/week_task_model.dart';
import 'package:todo_list/app/service/tasks/tasks_service_interface.dart';

class HomeController extends AppChangeNotifier {
  final ITasksService _tasksService;
  var filterSelected = TaskFilterEnum.today;
  TotalTaskModel? todayTotalTask;
  TotalTaskModel? tomorrowTotalTask;
  TotalTaskModel? weekTotalTask;

  HomeController({required ITasksService tasksService}) : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTask = TotalTaskModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTask = TotalTaskModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTask = TotalTaskModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    );
  }
}
