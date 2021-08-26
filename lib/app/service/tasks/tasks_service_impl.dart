import 'package:todo_list/app/repositories/tasks/tasks_repository_interface.dart';
import 'package:todo_list/app/service/tasks/tasks_service_interface.dart';

class TasksServiceImpl implements ITasksService {
  final ITasksRepository _taskRepository;

  TasksServiceImpl({required ITasksRepository taskRepository}) : _taskRepository = taskRepository;

  @override
  Future<void> save(DateTime date, String description) => _taskRepository.save(date, description);
}
