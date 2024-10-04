import 'package:dart_either/dart_either.dart';
import 'package:machine_test_dfine/core/errors.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/category_model.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/todo_model.dart';

abstract class TodoRepo {
Future<Either<AppExceptions,void>> addCategory(CategoryModel categoryModel);
Future<Either<AppExceptions,void>> addTodo(String categoryName,TodoModel todoModel);
}