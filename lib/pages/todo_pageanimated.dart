import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo_app/componants/dialog_box.dart';
import 'package:todo_app/componants/todo_tile.dart';
import 'package:todo_app/data/database.dart';

class TodoPage_animated extends StatefulWidget {
  const TodoPage_animated({super.key});

  @override
  State<TodoPage_animated> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage_animated> {
  // access hive box
  final _mybox = Hive.box('mybox');

  //
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the first time runnig app
    if (_mybox.get('TODOLIST') == null) {
      db.createinitialdata();
    } else {
      //there is data
      db.loadData();
    }
    super.initState();
  }

  // Text controller
  final TextEditingController Mycontroller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Checkbox changed
  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.updateDatabase();
  }

  // Saving new task
  void saveNewTask() {
    if (Mycontroller.text != "") {
      setState(() {
        db.todolist.add([Mycontroller.text, false]);
        Mycontroller.clear();
      });
      _listKey.currentState?.insertItem(db.todolist.length - 1);
      Navigator.of(context).pop();
      db.updateDatabase();
    }
  }

  // Deleting task
  void deleteTask(int index) {
    final removedTask = db.todolist.removeAt(index);
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
    db.updateDatabase();
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
        initialItemCount: db.todolist.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: ToDoTile(
              taskname: db.todolist[index][0],
              taskCompleted: db.todolist[index][1],
              onChanged: (value) => checkboxchanged(value, index),
              onDelete: () => deleteTask(index),
            ),
          );
        },
      ),
    );
  }
}
