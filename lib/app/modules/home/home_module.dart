import 'package:provider/provider.dart';
import 'package:todo_list/app/core/modules/todo_list_module.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/home_page.dart';
import 'package:todo_list/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:todo_list/app/repositories/tasks/tasks_repository_interface.dart';
import 'package:todo_list/app/service/tasks/tasks_service_impl.dart';
import 'package:todo_list/app/service/tasks/tasks_service_interface.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          bindings: [
            Provider<ITasksRepository>(
              create: (context) => TasksRepositoryImpl(sqliteConnectionFactory: context.read()),
            ),
            Provider<ITasksService>(
              create: (context) => TasksServiceImpl(taskRepository: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) => HomeController(tasksService: context.read()),
            ),
          ],
          routers: {
            '/home': (context) => HomePage(
                  homeController: context.read(),
                ),
          },
        );
}
