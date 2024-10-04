import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_dfine/features/addtodo/presentation/bloc/todo_bloc.dart';
import 'package:machine_test_dfine/features/common_widgets/custom_textfield.dart';

class TodoCategoriesPage extends StatefulWidget {
  const TodoCategoriesPage({super.key});

  @override
  State<TodoCategoriesPage> createState() => _TodoCategoriesPageState();
}

class _TodoCategoriesPageState extends State<TodoCategoriesPage> {
  final TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTextField(hintText: 'add search', 
          textEditingController: searchController),
          BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  
                },
              );
            },
          )
        ],
      ),
    );
  }
}