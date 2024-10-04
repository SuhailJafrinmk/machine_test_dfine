import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_dfine/core/theme.dart';
import 'package:machine_test_dfine/features/addtodo/data/repositories/todo_repo.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/bloc/todo_bloc.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository.dart';
import 'package:machine_test_dfine/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_dfine/features/authentication/presentation/pages/sign_in.dart';
import 'package:machine_test_dfine/firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
         create: (context) => AuthBloc(authRepository: di.sl<AuthRepository>()), 
        ),
        BlocProvider(
          create: (context) => TodoBloc(todoRepo: di.sl<TodoRepo>()),
        )
      ],
      child: MaterialApp(
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const SignInPage(),
      ),
    );
  }
}
