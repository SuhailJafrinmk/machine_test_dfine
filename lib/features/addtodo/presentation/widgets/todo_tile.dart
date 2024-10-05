import 'package:flutter/material.dart';
import 'package:machine_test_dfine/core/utility_functions.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/todo_model.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todoModel;
  const TodoTile({super.key, required this.todoModel});


  @override
  Widget build(BuildContext context) {
    final String formattedDate=UtilityFunctions.formatDateTime(todoModel.createdAt);
    final theme=Theme.of(context);
    return Card(
      elevation: 10,
      color: theme.listTileTheme.tileColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Todo Name
            Text(
              todoModel.title,
              style: theme.listTileTheme.titleTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              todoModel.description ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.listTileTheme.subtitleTextStyle,
            ),
            const SizedBox(height: 8),

            // Created At
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
