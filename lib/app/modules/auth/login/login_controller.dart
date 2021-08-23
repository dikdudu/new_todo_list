import 'package:todo_list/app/core/notifier/app_change_notifier.dart';
import 'package:todo_list/app/exception/auth_exception.dart';
import 'package:todo_list/app/service/user/user_service_interface.dart';

class LoginController extends AppChangeNotifier {
  final IUserService _userService;

  LoginController({required IUserService userService}) : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.login(email, password);
      if (user != null) {
        success();
      } else {
        setError("Usuario ou senha inválidos");
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
