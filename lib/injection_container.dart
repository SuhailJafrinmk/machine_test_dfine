import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:machine_test_dfine/config/firestore_paths.dart';
import 'package:machine_test_dfine/features/addtodo/data/datasources/firebase_todo_datasource.dart';
import 'package:machine_test_dfine/features/addtodo/data/repositories/todo_repo.dart';
import 'package:machine_test_dfine/features/addtodo/data/repositories/todo_repo_impl.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/category_bloc/todo_bloc.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/todo_bloc/manage_todo_bloc.dart';
import 'package:machine_test_dfine/features/authentication/data/data_sources/firebase_auth_datasource.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:machine_test_dfine/features/authentication/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<FirestorePaths>(()=>FirestorePaths(sl<FirebaseFirestore>()));
  sl.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasource(firebaseAuth: sl<FirebaseAuth>(), firebaseFirestore: sl<FirebaseFirestore>(),firestorePaths: sl<FirestorePaths>()),
  );
  sl.registerLazySingleton<FirebaseTodoDatasource>(()=>FirebaseTodoDatasource(firebaseFirestore: sl<FirebaseFirestore>(), firebaseAuth: sl<FirebaseAuth>(), firestorePaths: sl<FirestorePaths>()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(firebaseAuthDatasource: sl<FirebaseAuthDatasource>()),
  );
  sl.registerLazySingleton<TodoRepo>(
    () => TodoRepoImpl(firebaseTodoDatasource: sl<FirebaseTodoDatasource>()),
  );
  sl.registerFactory<AuthBloc>(()=>AuthBloc(authRepository: sl<AuthRepository>()));
  sl.registerFactory<TodoBloc>(()=>TodoBloc(todoRepo: sl<TodoRepo>()));
  sl.registerFactory<ManageTodoBloc>(()=>ManageTodoBloc(todoRepo: sl<TodoRepo>()));
}
