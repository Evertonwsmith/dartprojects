import 'package:flutter/material.dart';

void main() {
  runApp(todo());
}

class todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<String> tasks = ['Buy groceries', 'Walk the dog', 'Finish homework'];
  String _newTask = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add New Task'),
              content: TextField(
                onChanged: (value) {
                  setState(() {
                    _newTask = value;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_newTask.isNotEmpty) {
                      setState(() {
                        tasks.add(_newTask);
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReorderableListView(
          onReorder: _onReorder,
          children: [
            for (int index = 0; index < tasks.length; index++)
              Dismissible(
                key: ValueKey(index),
                onDismissed: (direction) {
                  setState(() {
                    tasks.removeAt(index);
                  });
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(tasks[index]),
                  tileColor: Colors.blueGrey[50],
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final task = tasks.removeAt(oldIndex);
      tasks.insert(newIndex, task);
    });
  }
}
