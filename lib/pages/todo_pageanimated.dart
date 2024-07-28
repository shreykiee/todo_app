import 'package:flutter/material.dart';

import 'package:todo_app/componants/dialog_box.dart';
import 'package:todo_app/componants/todo_tile.dart';

class TodoPage_animated extends StatefulWidget {
  const TodoPage_animated({super.key});

  @override
  State<TodoPage_animated> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage_animated> {
  // Text controller
  final TextEditingController Mycontroller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<List<dynamic>> todolist = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Checkbox changed
  void checkboxchanged(bool? value, int index) {
    setState(() {
      todolist[index][1] = !todolist[index][1];
    });
  }

  // Saving new task
  void saveNewTask() {
    if (Mycontroller.text != "") {
      setState(() {
        todolist.add([Mycontroller.text, false]);
        Mycontroller.clear();
      });
      _listKey.currentState?.insertItem(todolist.length - 1);
      Navigator.of(context).pop();
    }
  }

  // Deleting task
  void deleteTask(int index) {
    final removedTask = todolist.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: ToDoTile(
          taskname: removedTask[0],
          taskCompleted: removedTask[1],
          onChanged: (value) => checkboxchanged(value, index),
          onDelete: () {},
        ),
      ),
    );
  }

  // Creating new task
  void CreateNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: Mycontroller,
          focusNode: _focusNode,
          onCancel: () => {Navigator.of(context).pop(), Mycontroller.clear()},
          onSave: saveNewTask,
        );
      },
    ).then((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        // backgroundColor: Colors.yellow,
        backgroundColor: Colors.yellow[300],
        elevation: 3,
        shadowColor: Colors.black,

        title: const Center(child: Text("TO DO")),
      ),
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 20),
        child: FloatingActionButton(
          onPressed: CreateNewTask,
          backgroundColor: Colors.yellow[400],
          child: const Icon(Icons.add),
        ),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: todolist.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: ToDoTile(
              taskname: todolist[index][0],
              taskCompleted: todolist[index][1],
              onChanged: (value) => checkboxchanged(value, index),
              onDelete: () => deleteTask(index),
            ),
          );
        },
      ),
    );
  }
}
