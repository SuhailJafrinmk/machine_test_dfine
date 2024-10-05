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
    on<FetchCategories>(fetchCategories);
  }

  FutureOr<void> addCategory(AddCategory event, Emitter<TodoState> emit)async{
    emit(TodoLoading());
    final response=await todoRepo.addCategory(event.categoryModel);
    response.fold(ifLeft: (failure){
      emit(TodoError(message: failure.errorMessage));
    }, ifRight: (success){
      emit(AddedCategory());
    });
  }



  FutureOr<void> fetchCategories(FetchCategories event, Emitter<TodoState> emit)async{
    emit(TodoLoading());
    final response=await todoRepo.getCategories();
    response.fold(
      ifLeft: (failure){
       emit(TodoError(message: failure.errorMessage));
      },
       ifRight: (success){
        emit(FetcedCategories(categoryModel: success));
       }
       );
  }
}
