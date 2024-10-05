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
        // Adding the Drawer with profile image and tiles
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // Drawer Header with Profile Image
              UserAccountsDrawerHeader(
                accountName: Text('John Doe'),
                accountEmail: Text('john.doe@example.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/profile_image.jpg'), // Change this to your profile image asset path
                ),
              ),
              // List of Drawer Items
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Handle Settings tap
                },
              ),
              ListTile(
                leading: Icon(Icons.brightness_6),
                title: Text('Theme'),
                onTap: () {
                  // Handle Theme tap
                },
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if(state is SignOutSuccess){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
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
                  if (state is FetcedCategories) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: state.categoryModel.length +
                          1, // Add 1 for the blank card
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) {
                        if (index == state.categoryModel.length) {
                          // The last item should be the blank card with the button
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
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
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
                            createdAt: DateTime.now())));
                    Navigator.pop(
                        context); // Close the modal after adding the category
                  }
                },
                child: const Text('Add Category'),
              ),
            ],
          ),
        );
      },
    );
  }
}
