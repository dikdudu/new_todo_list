import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/navigator/app_navigator.dart';
import 'package:todo_list/app/service/user/user_service_interface.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final IUserService _userService;

  AuthProvider({required FirebaseAuth firebaseAuth, required IUserService userService})
      : _firebaseAuth = firebaseAuth,
        _userService = userService;

  Future<void> logout() => _userService.logout();

  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.idTokenChanges().listen((user) {
      if (user != null) {
        AppNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        AppNavigator.to.pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}
