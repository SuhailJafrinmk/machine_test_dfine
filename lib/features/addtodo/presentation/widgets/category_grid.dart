import 'package:flutter/material.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/category_model.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/pages/category_todos_page.dart';
import 'package:machine_test_dfine/features/common_widgets/custom_textfield.dart';

class CategoryGrid extends StatelessWidget {
  final CategoryModel categoryModel;
  final int totalCategories;

  const CategoryGrid({super.key, required this.categoryModel, required this.totalCategories});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TodosInCategoryPage(categoryName: categoryModel.categoryName)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(categoryModel.categoryName,
             style: Theme.of(context).textTheme.headlineMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
             ),
            const SizedBox(height: 10),
            Text(
              '$totalCategories Tasks', 
            style: Theme.of(context).textTheme.labelLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTodoModal(BuildContext context, CategoryModel category) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,  // to allow keyboard interaction properly
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,  // handle keyboard overlap
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add New Todo for ${category.categoryName}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Todo Title',
                textEditingController: titleController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Todo Description',
                textEditingController: descriptionController,
                // maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Dispatch event to add todo corresponding to this category
                  // BlocProvider.of<TodoBloc>(context).add(
                  //   // AddTodo(categoryName: category.categoryName, todoModel: TodoModel(title: titleController.text, createdAt: DateTime.now(),description: descriptionController.text))
                  // );
                  Navigator.pop(context);  // Close modal after adding todo
                },
                child: const Text('Add Todo'),
              ),
            ],
          ),
        );
      },
    );
  }
}
