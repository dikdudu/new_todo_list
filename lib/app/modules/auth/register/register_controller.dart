import 'package:todo_list/app/core/notifier/app_change_notifier.dart';
import 'package:todo_list/app/exception/auth_exception.dart';

import 'package:todo_list/app/service/user/user_service_interface.dart';

class RegisterController extends AppChangeNotifier {
  final IUserService _userService;

  RegisterController({
    required IUserService userService,
  }) : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);
      success();
      if (user != null) {
      } else {
        setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
