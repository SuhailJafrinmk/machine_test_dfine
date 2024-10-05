import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/todo_model.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/todo_bloc/manage_todo_bloc.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/widgets/todo_tile.dart';

class TodosInCategoryPage extends StatelessWidget {
  final String categoryName;
  
  const TodosInCategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Trigger the event to fetch todos when this page is loaded
    context.read<ManageTodoBloc>().add(FetchTodos(categoryName: categoryName));

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: BlocBuilder<ManageTodoBloc, ManageTodoState>(
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is TodosFetchedSuccess) {
            final todos = state.Todos;
            if (todos.isEmpty) {
              return  Center(child: Text('No todos available for $categoryName.'));
            }
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoTile(
                  todoModel: todo,
                );
              },
            );
          } else {
            return const Center(
              child: Text('Unexpected error occurred.'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoModal(context,categoryName),
        child: const Icon(Icons.add),
      ),
    );
  }

void _showAddTodoModal(BuildContext context, String categoryName) {
  final TextEditingController todoNameController = TextEditingController();
  final TextEditingController todoDescriptionController = TextEditingController();
  
  showModalBottomSheet(
    isScrollControlled: true, // Allows modal to resize when the keyboard appears
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust padding for keyboard
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: todoNameController,
                decoration: const InputDecoration(
                  labelText: 'Todo Name',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: todoDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (todoNameController.text.isNotEmpty) {
                    final newTodo = TodoModel(
                      title: todoNameController.text,
                      description: todoDescriptionController.text,
                      createdAt: DateTime.now(),
                    );
                    context.read<ManageTodoBloc>().add(
                      AddTodo(
                        categoryName: categoryName,
                        todoModel: newTodo,
                      ),
                    );
                    Navigator.pop(context); // Close the modal
                  }
                },
                child: const Text('Add Todo'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

}
