import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/category_model.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/todo_model.dart';
import 'package:machine_test_dfine/features/addtodo/data/repositories/todo_repo.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo todoRepo;
  TodoBloc({required this.todoRepo}) : super(TodoInitial()) {
    on<AddCategory>(addCategory);
    on<AddTodo>(addTodo);
  }

  FutureOr<void> addCategory(AddCategory event, Emitter<TodoState> emit)async{
    final response=await todoRepo.addCategory(event.categoryModel);
    response.fold(ifLeft: (failure){

    }, ifRight: (success){
      
    });
  }

  FutureOr<void> addTodo(AddTodo event, Emitter<TodoState> emit)async{
    final response=await todoRepo.addTodo(event.categoryName, event.todoModel);
    response.fold(
      ifLeft: (failure){

      },
       ifRight: (success){

       });
  }
}
