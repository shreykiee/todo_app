import 'package:flutter/material.dart';
import 'package:todo_app/componants/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter new task",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  )),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              //buttons

              //save
              MyButton(
                text: 'Save',
                onPressed: onSave,
              ),
              const SizedBox(
                width: 8,
              ),
              //cancel
              MyButton(
                text: 'cancel',
                onPressed: onCancel,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
