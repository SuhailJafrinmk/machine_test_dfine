import 'package:dart_either/src/dart_either.dart';
import 'package:machine_test_dfine/core/errors.dart';
import 'package:machine_test_dfine/features/addtodo/data/datasources/firebase_todo_datasource.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/category_model.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/todo_model.dart';
import 'package:machine_test_dfine/features/addtodo/data/repositories/todo_repo.dart';

class TodoRepoImpl implements TodoRepo{
  final FirebaseTodoDatasource firebaseTodoDatasource;
  TodoRepoImpl({required this.firebaseTodoDatasource});
  @override
  Future<Either<AppExceptions, void>> addCategory(CategoryModel categoryModel) {
    return firebaseTodoDatasource.addCategory(categoryModel);
  }

  @override
  Future<Either<AppExceptions, void>> addTodo(String categoryName, TodoModel todoModel) {
    return firebaseTodoDatasource.addTodo(categoryName, todoModel);
  }
}