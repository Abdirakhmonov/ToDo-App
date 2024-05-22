import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../controllers/todo_controller.dart';
import '../widgets/add_dialog.dart';
import '../widgets/plan_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoController todoController = TodoController();

  void onDone(int i) {
    todoController.todoList[i].checkDone =
    !todoController.todoList[i].checkDone;
    setState(() {});
  }

  void onDeleted(int i) {
    todoController.deletePlan(i);
    setState(() {});
  }

  void onEdited() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int counter = todoController.counter();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("To Do App", style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Bajarilgan: ${todoController.todoList.length - counter}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                "Bajarilmagan: $counter",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: todoController.todoList.length,
              itemBuilder: (context, i) {
                return PlanWidget(
                  model: todoController.todoList[i],
                  onDone: () => onDone(i),
                  onDeleted: () => onDeleted(i),
                  onEdited: onEdited,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          Map<String, dynamic>? data = await showDialog(
            context: context,
            builder: (context) {
              return AddDialog();
            },
          );
          if (data != null) {
            todoController.add(data["title"], data["date"]);
          }
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
