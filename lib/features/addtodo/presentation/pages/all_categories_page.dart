import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/category_model.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/category_bloc/todo_bloc.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/widgets/category_grid.dart';
import 'package:machine_test_dfine/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_dfine/features/authentication/presentation/pages/sign_in.dart';
import 'package:machine_test_dfine/features/common_widgets/custom_textfield.dart';

class TodoCategoriesPage extends StatefulWidget {
  const TodoCategoriesPage({super.key});

  @override
  State<TodoCategoriesPage> createState() => _TodoCategoriesPageState();
}

class _TodoCategoriesPageState extends State<TodoCategoriesPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<TodoBloc>().add(FetchCategories());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is AddedCategory) {
          BlocProvider.of<TodoBloc>(context).add(FetchCategories());
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: const Text('John Doe'),
                accountEmail: const Text('john.doe@example.com'),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_image.jpg'),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Theme'),
                onTap: () {},
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignOutSuccess) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  }
                },
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(LogoutUserEvent());
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                hintText: 'Search categories',
                textEditingController: searchController,
              ),
            ),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TodoError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, size: 40, color: Colors.red),
                          const SizedBox(height: 8),
                          Text(state.message, style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<TodoBloc>().add(FetchCategories());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  } else if (state is FetcedCategories) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: state.categoryModel.length + 1, // Add 1 for the blank card
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) {
                        if (index == state.categoryModel.length) {
                          return _buildAddCategoryCard(context);
                        }
                        final item = state.categoryModel[index];
                        return CategoryGrid(
                          categoryModel: item,
                          totalCategories: state.categoryModel.length,
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the blank card with a button
  Widget _buildAddCategoryCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddCategoryModal(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, size: 40, color: Colors.black),
              const SizedBox(height: 8),
              const Text('Add Category', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the modal for adding a new category
void _showAddCategoryModal(BuildContext context) {
  final TextEditingController categoryController = TextEditingController();
  
  showModalBottomSheet(
    isScrollControlled: true, // This allows the modal to resize when the keyboard appears
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust padding based on keyboard
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(  // Allows content to be scrollable
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add New Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Enter category name',
                textEditingController: categoryController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (categoryController.text.isNotEmpty) {
                    BlocProvider.of<TodoBloc>(context).add(AddCategory(
                      categoryModel: CategoryModel(
                        categoryName: categoryController.text,
                        createdAt: DateTime.now(),
                      ),
                    ));
                    Navigator.pop(context); // Close the modal after adding the category
                  }
                },
                child: const Text('Add Category'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

}
