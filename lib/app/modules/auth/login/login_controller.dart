import 'package:todo_list/app/core/notifier/app_change_notifier.dart';
import 'package:todo_list/app/exception/auth_exception.dart';
import 'package:todo_list/app/service/user/user_service_interface.dart';

class LoginController extends AppChangeNotifier {
  final IUserService _userService;
  String? infoMessage;

  LoginController({
    required IUserService userService,
  }) : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.googleLogin();
      if (user != null) {
        success();
      } else {
        _userService.logout();
        setError('Erro ao realizar login com o google');
      }
    } on AuthException catch (e) {
      _userService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
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

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para seu email';
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Errro ao resetar senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
