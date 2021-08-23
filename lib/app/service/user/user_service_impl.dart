import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list/app/repositories/user/user_repository_interface.dart';

import 'user_service_interface.dart';

class UserServiceImpl implements IUserService {
  final IUserRepository _userRepoository;

  UserServiceImpl({
    required IUserRepository userRepository,
  }) : _userRepoository = userRepository;

  @override
  Future<User?> register(String email, String password) => _userRepoository.register(email, password);

  @override
  Future<User?> login(String email, String password) => _userRepoository.login(email, password);

  @override
  Future<void> forgotPassword(String email) => _userRepoository.forgotPassword(email);
}
