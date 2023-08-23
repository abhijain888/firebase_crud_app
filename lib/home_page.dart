import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/add_todo_page.dart';
import 'package:firebase_crud/detail_screen.dart';
import 'package:firebase_crud/task_model.dart';
import 'package:firebase_crud/util.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String version = "";

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  void initState() {
    getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebabse-CRUD"),
        centerTitle: false,
        actions: [
          Text(
            version,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
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
                          (e) => Dismissible(
                            key: Key(e.id),
                            background: const DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart ||
                                  direction == DismissDirection.startToEnd) {
                                deleteTask(e.id);
                              }
                            },
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => DetailScreen(
                                            desc: e.description ?? "",
                                            task: e.todo ?? "",
                                            createdAt:
                                                formatTimestamp(e.createdAt),
                                          )),
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

  void deleteTask(String id) =>
      FirebaseFirestore.instance.collection("tasks").doc(id).delete();
}
