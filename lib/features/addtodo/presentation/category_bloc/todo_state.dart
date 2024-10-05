part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}
final class TodoInitial extends TodoState {}
class FetcedCategories extends TodoState{
  final List<CategoryModel> categoryModel;
  FetcedCategories({required this.categoryModel});
}
class AddedCategory extends TodoState{}
class TodoError extends TodoState{
  final String message;
  TodoError({required this.message});
}