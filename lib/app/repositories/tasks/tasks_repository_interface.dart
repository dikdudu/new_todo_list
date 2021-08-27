import 'package:todo_list/app/models/task_model.dart';

abstract class ITasksRepository {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
}
