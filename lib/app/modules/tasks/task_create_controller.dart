import 'package:todo_list/app/core/notifier/app_change_notifier.dart';
import 'package:todo_list/app/service/tasks/tasks_service_interface.dart';

class TaskCreateController extends AppChangeNotifier {
  final ITasksService _tasksService;
  DateTime? _selectedDate;

  TaskCreateController({
    required ITasksService tasksService,
  }) : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      if (_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da task não selecionada');
      }
    } catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
