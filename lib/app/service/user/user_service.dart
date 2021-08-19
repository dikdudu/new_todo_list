import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list/app/repositories/user/user_repository.dart';

abstract class IUserService {
  Future<User?> register(String email, String password);
}

class UserService implements IUserService {
  final UserRepository _userRepoository;

  UserService({
    required UserRepository userRepository,
  }) : _userRepoository = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepoository.register(email, password);
}
