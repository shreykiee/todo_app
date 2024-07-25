import 'package:flutter/material.dart';
import 'package:todo_app/componants/dialog_box.dart';
import 'package:todo_app/componants/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List todolist = [
    ["make tea", true],
    ["drink tea", false]
  ];

  //checkbox changed
  void checkboxchanged(bool? value, int index) {
    setState(() {
      todolist[index][1] = !todolist[index][1];
    });
  }

  //creating new task
  void CreateNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Center(child: Text("TO DO")),
      ),
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 20),
        child: FloatingActionButton(
          onPressed: CreateNewTask,
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow,
        ),
      ),
      body: ListView.builder(
        itemCount: todolist.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskname: todolist[index][0],
            taskCompleted: todolist[index][1],
            onChanged: (value) => checkboxchanged(value, index),
          );
        },
      ),
    );
  }
}
