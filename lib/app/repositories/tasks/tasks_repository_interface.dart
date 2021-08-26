abstract class ITasksRepository {
  Future<void> save(DateTime date, String description);
}
