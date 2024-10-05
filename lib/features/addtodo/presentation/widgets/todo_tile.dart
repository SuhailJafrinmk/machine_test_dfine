import 'package:flutter/material.dart';
import 'package:machine_test_dfine/features/addtodo/data/models/todo_model.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todoModel;
  const TodoTile({super.key, required this.todoModel});


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Todo Name
            Text(
              todoModel.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Todo Description with max lines = 2 and overflow handling
            Text(
              todoModel.description ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),

            // Created At
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${todoModel.createdAt}',
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
