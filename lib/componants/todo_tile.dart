import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToDoTile extends StatelessWidget {
  final String taskname;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  VoidCallback onDelete;
  ToDoTile(
      {super.key,
      required this.taskname,
      required this.taskCompleted,
      required this.onChanged,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    String delete = 'delete the task';
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.yellow[300], borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Checkbox(value: taskCompleted, onChanged: onChanged),
            Expanded(
              child: Text(
                taskname,
                style: TextStyle(
                    fontSize: 18,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.delete, color: Colors.orange),
              onPressed: onDelete,
              tooltip: delete,
            )
          ],
        ),
      ),
    );
  }
}
