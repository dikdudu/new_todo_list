import 'package:todo_list/app/core/notifier/app_change_notifier.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';

class HomeController extends AppChangeNotifier {
  TaskFilterEnum filterSelected = TaskFilterEnum.today;
}
