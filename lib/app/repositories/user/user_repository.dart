import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/app/exception/auth_exception.dart';

abstract class IUserRepository {
  Future<User?> register(String email, String password);
}

class UserRepository implements IUserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      //email-already-exists
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: "E-mail já utilizado, por favor escolha outro e-mail");
        } else {
          throw AuthException(
              message:
                  "Você se cadastrou pelo Google, por favor utilize ele para entrar!!!");
        }
      } else {
        throw AuthException(message: e.message ?? "Erro ao registrar usuário");
      }
    }
  }
}
