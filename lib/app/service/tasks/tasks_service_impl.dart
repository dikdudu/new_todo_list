import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/models/week_task_model.dart';
import 'package:todo_list/app/repositories/tasks/tasks_repository_interface.dart';
import 'package:todo_list/app/service/tasks/tasks_service_interface.dart';

class TasksServiceImpl implements ITasksService {
  final ITasksRepository _taskRepository;

  TasksServiceImpl({required ITasksRepository taskRepository}) : _taskRepository = taskRepository;

  @override
  Future<void> save(DateTime date, String description) => _taskRepository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _taskRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrowDate = DateTime.now().add(Duration(days: 1));
    return _taskRepository.findByPeriod(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter = startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }

    endFilter = startFilter.add(Duration(days: 7));
    final tasks = await _taskRepository.findByPeriod(startFilter, endFilter);

    return WeekTaskModel(
      startDate: startFilter,
      endDate: endFilter,
      tasks: tasks,
    );
  }
}
