import 'package:hive/hive.dart';

class ToDoDatabase {
  //open the hive box
  final _mybox = Hive.box('mybox');

  List todolist = [];

  //create initial data
  void createinitialdata() {
    todolist = [
      ["do excersie", false],
      ["do lunch", true]
    ];
  }

  //load the data from database
  void loadData() {
    todolist = _mybox.get("TODOLIST");
  }

  void updateDatabase() {
    _mybox.put("TODOLIST", todolist);
  }
  //update the database
}
