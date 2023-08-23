import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/add_todo_page.dart';
import 'package:firebase_crud/detail_screen.dart';
import 'package:firebase_crud/task_model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebabse-CRUD"),
      ),
      body: StreamBuilder(
        stream: getTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data!;

            return tasks.isEmpty
                ? const Center(
                    child: Text("Tap on '+' button to add a new task"),
                  )
                : ListView(
                    children: tasks
                        .map(
                          (e) => ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const DetailScreen()),
                              );
                            },
                            title: Text(
                              e.todo ?? "",
                              style: TextStyle(
                                  decoration: (e.isCompleted ?? false)
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            trailing: Checkbox(
                              value: e.isCompleted,
                              onChanged: (value) {
                                var update = e
                                    .copyWith(isCompleted: !(e.isCompleted!))
                                    .toMap();
                                toggleTask(update, e.id);
                              },
                            ),
                          ),
                        )
                        .toList(),
                  );
          } else if (snapshot.hasError) {
            return const Text("Something bad occured");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Stream<List<Task>> getTasks() => FirebaseFirestore.instance
      .collection("tasks")
      .snapshots()
      .map((e) => e.docs.map((d) => Task.fromMap(d.data())).toList());

  void toggleTask(Map<String, dynamic> update, String id) async {
    try {
      var doc = FirebaseFirestore.instance.collection("tasks").doc(id);
      await doc.update(update);
    } on Exception catch (e) {
      print(e);
    }
  }
}
