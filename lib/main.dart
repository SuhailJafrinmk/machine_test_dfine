import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_dfine/config/check_connectivity_cubit/connectivity_cubit.dart';
import 'package:machine_test_dfine/core/theme.dart';
import 'package:machine_test_dfine/features/addtodo/data/repositories/todo_repo.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/category_bloc/todo_bloc.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/todo_bloc/manage_todo_bloc.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository.dart';
import 'package:machine_test_dfine/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_dfine/features/authentication/presentation/pages/splash_screen.dart';
import 'package:machine_test_dfine/firebase_options.dart';
import 'injection_container.dart' as di;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
          create: (context) =>
              AuthBloc(authRepository: di.sl<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) => TodoBloc(todoRepo: di.sl<TodoRepo>()),
        ),
        BlocProvider(
          create: (context) => ManageTodoBloc(todoRepo: di.sl<TodoRepo>()),
        ),
        BlocProvider(
          create: (context) => ConnectivityCubit(),
        )
      ],
      child: BlocListener<ConnectivityCubit, InternetStatus>(
        listener: (context, state) {
          if(state.status==ConnectivityStatus.disconnected){
            _showNoConnectionDialog();
          }else{
            _dismissNoConnectionDialog();
          }
        },
        child: MaterialApp(
          theme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }

   void _showNoConnectionDialog() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (context) => WillPopScope(
          onWillPop: () async => false, 
          child: AlertDialog(
            title: const Text('No Connection'),
            content: const Text('You are not connected to the internet.\nPlease connect to the internet to dismiss this dialogue'),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    }
  }
    void _dismissNoConnectionDialog() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }
}

