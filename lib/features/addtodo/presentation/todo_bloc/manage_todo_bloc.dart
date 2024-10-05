import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/todo_model.dart';
import 'package:machine_test_dfine/features/addtodo/data/repositories/todo_repo.dart';
import 'package:meta/meta.dart';

part 'manage_todo_event.dart';
part 'manage_todo_state.dart';

class ManageTodoBloc extends Bloc<ManageTodoEvent, ManageTodoState> {
  final TodoRepo todoRepo;
  ManageTodoBloc({required this.todoRepo}) : super(ManageTodoInitial()) {
    on<FetchTodos>(fetchTodos);
    on<AddTodo>(addTodo);
  }

  FutureOr<void> fetchTodos(FetchTodos event, Emitter<ManageTodoState> emit)async{
    emit(TodoLoadingState());
    final response=await todoRepo.getTodos(event.categoryName);
    response.fold(
      ifLeft: (failure){
        emit(ErrorState(message: failure.errorMessage));
      },
       ifRight: (success){
        emit(TodosFetchedSuccess(Todos: success));
       });
  }

  FutureOr<void> addTodo(AddTodo event, Emitter<ManageTodoState> emit)async{
    emit(TodoLoadingState());
    final response=await todoRepo.addTodo(event.categoryName, event.todoModel);
    response.fold(
      ifLeft: (failure){
        emit(ErrorState(message: failure.errorMessage));
      }, 
      ifRight: (success){
        emit(TodoAddedSuccess());
      });
  }
}
