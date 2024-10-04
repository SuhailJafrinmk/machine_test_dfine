import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/category_model.dart';

class CategoryGrid extends StatelessWidget {
  final CategoryModel categoryModel;
  final int totalCategories;

  const CategoryGrid({super.key, required this.categoryModel,required this.totalCategories});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(categoryModel.categoryName),
          SizedBox(height: 10,),
          Text('$totalCategories Tasks'),
        ],
      ),
    );
  }
}