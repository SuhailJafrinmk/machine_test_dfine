part of 'manage_todo_bloc.dart';

@immutable
sealed class ManageTodoEvent {}
class FetchTodos extends ManageTodoEvent{
  final String categoryName;
  FetchTodos({required this.categoryName});
}
class AddTodo extends ManageTodoEvent{
  final String categoryName;
  final TodoModel todoModel;
  AddTodo({required this.categoryName,required this.todoModel});
}
