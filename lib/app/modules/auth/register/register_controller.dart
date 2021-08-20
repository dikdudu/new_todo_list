import 'package:flutter/material.dart';
import 'package:todo_list/app/exception/auth_exception.dart';

import 'package:todo_list/app/service/user/user_service_interface.dart';

class RegisterController extends ChangeNotifier {
  final IUserService _userService;
  String? error;
  bool success = false;

  RegisterController({
    required IUserService userService,
  }) : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();
      final user = await _userService.register(email, password);
      success = true;
      if (user != null) {
      } else {
        error = 'Erro ao registrar usuário';
      }
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
