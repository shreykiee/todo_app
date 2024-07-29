import 'package:flutter/material.dart';

import 'package:todo_app/componants/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Add a task',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
