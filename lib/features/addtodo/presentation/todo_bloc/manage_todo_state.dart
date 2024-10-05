part of 'manage_todo_bloc.dart';

@immutable
sealed class ManageTodoState {}

final class ManageTodoInitial extends ManageTodoState {}
class TodoLoadingState extends ManageTodoState{}
class TodosFetchedSuccess extends ManageTodoState{
  final List<TodoModel> Todos;
  TodosFetchedSuccess({required this.Todos});
}
class TodoAddedSuccess extends ManageTodoState{

}

class ErrorState extends ManageTodoState{
  final String message;
  ErrorState({required this.message});
}
