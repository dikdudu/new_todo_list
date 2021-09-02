import 'package:todo_list/app/core/notifier/app_change_notifier.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/models/total_task_model.dart';
import 'package:todo_list/app/models/week_task_model.dart';
import 'package:todo_list/app/service/tasks/tasks_service_interface.dart';

class HomeController extends AppChangeNotifier {
  final ITasksService _tasksService;
  var filterSelected = TaskFilterEnum.tomorrow;
  TotalTaskModel? todayTotalTask;
  TotalTaskModel? tomorrowTotalTask;
  TotalTaskModel? weekTotalTask;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectadDay;

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

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;

      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (selectadDay != null) {
        filterByDay(selectadDay!);
      } else if (initialDateOfWeek != null) {
        filterByDay(initialDateOfWeek!);
      }
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    // selectadDay = date;
    filteredTasks = allTasks.where((task) {
      return task.dateTime == date;
    }).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }
}
