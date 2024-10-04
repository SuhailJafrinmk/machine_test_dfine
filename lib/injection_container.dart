import 'package:get_it/get_it.dart';
import 'package:machine_test_dfine/features/addtodo/data/repositories/todo_repo.dart';
import 'package:machine_test_dfine/features/addtodo/data/repositories/todo_repo_impl.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository.dart';
import 'package:machine_test_dfine/features/authentication/data/repositories/auth_repository_impl.dart';

final sl=GetIt.instance;
Future<void>init()async{
  sl.registerLazySingleton(()=>AuthRepository as AuthRepositoryImpl);
  sl.registerLazySingleton(()=>TodoRepo as TodoRepoImpl);
}