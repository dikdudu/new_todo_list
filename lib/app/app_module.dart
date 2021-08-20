import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/app_widget.dart';
import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list/app/repositories/user/user_repository_impl.dart';
import 'package:todo_list/app/service/user/user_service_impl.dart';

import 'repositories/user/user_repository_interface.dart';
import 'service/user/user_service_interface.dart';

class AppModule extends StatelessWidget {
  AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
        Provider<IUserRepository>(
          create: (context) => UserRepositoryImpl(firebaseAuth: context.read()),
        ),
        Provider<IUserService>(
          create: (context) => UserServiceImpl(userRepository: context.read()),
        ),
      ],
      child: AppWidget(),
    );
  }
}
