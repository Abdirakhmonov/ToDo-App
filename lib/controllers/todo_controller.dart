
import '../models/todo_model.dart';

class TodoController {
  final _todoList = [
    TodoModel(title: "Badan tarbiya", date: "06:00", checkDone: false),
    TodoModel(title: "Darsga borish", date: "08:00", checkDone: false),
    TodoModel(title: "Futbolga borish", date: "20:00", checkDone: false),
  ];

  List<TodoModel> get todoList {
    return [..._todoList];
  }

  void deletePlan(int index) {
    _todoList.removeAt(index);
  }

  void add(String name, String date) {
    _todoList.add(
      TodoModel(title: name, date: date, checkDone: false),
    );
  }

  int counter() {
    int counter = 0;
    for (var i in _todoList) {
      if (i.checkDone != true) {
        counter++;
      }
    }
    return counter;
  }
}