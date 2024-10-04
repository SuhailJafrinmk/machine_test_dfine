part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}
class AddCategory extends TodoEvent{
  final CategoryModel categoryModel;
  AddCategory({required this.categoryModel});
}
class AddTodo extends TodoEvent{
  final String categoryName;
  final TodoModel todoModel;
  AddTodo({required this.categoryName,required this.todoModel});
}