import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/todo_model.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/todo_bloc/manage_todo_bloc.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/widgets/todo_tile.dart';
import 'package:machine_test_dfine/features/common_widgets/snackbar.dart';

class TodosInCategoryPage extends StatelessWidget {
  final String categoryName;
  
  const TodosInCategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
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
        backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
        onPressed: () => _showAddTodoModal(context,categoryName),
        child:  Icon(Icons.add,color: theme.floatingActionButtonTheme.hoverColor,),
      ),
    );
  }

void _showAddTodoModal(BuildContext context, String categoryName) {
  final TextEditingController todoNameController = TextEditingController();
  final TextEditingController todoDescriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    isScrollControlled: true, 
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: todoNameController,
                  decoration: const InputDecoration(
                    labelText: 'Todo Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Todo Name cannot be empty';
                    }else if(value.length>30){
                      return 'Make shorter titles up to 30 chars';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: todoDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Validation passed, add the todo
                      final newTodo = TodoModel(
                        title: todoNameController.text.trim(),
                        description: todoDescriptionController.text.trim(),
                        createdAt: DateTime.now(),
                      );
                      context.read<ManageTodoBloc>().add(
                        AddTodo(
                          categoryName: categoryName,
                          todoModel: newTodo,
                        ),
                      );
                      Navigator.pop(context); // Close the modal after adding the todo
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, true, 'Please check your input'));
                    }
                  },
                  child: const Text('Add Todo'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

}
