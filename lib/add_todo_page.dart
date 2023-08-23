import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/task_model.dart';
import 'package:firebase_crud/util.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final taskController = TextEditingController();
  final descController = TextEditingController();
  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                hintText: "Write your task here",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                hintText: "Add some description (optional)",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => addTask(
                context: context,
                task: taskController.text,
                desc: descController.text,
              ),
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }

  void addTask({
    required BuildContext context,
    required String task,
    required String desc,
  }) async {
    try {
      var doc = FirebaseFirestore.instance.collection("tasks").doc();

      var data = Task(
        id: doc.id,
        todo: task,
        description: desc,
        createdAt: FieldValue.serverTimestamp(),
      );

      await doc.set(data.toMap());

      if (context.mounted) {
        showSnackar(context: context, message: "Task added successfully");
        Navigator.of(context).pop();
      }
    } on Exception catch (e) {
      print(e);
      if (context.mounted) showSnackar(context: context, message: e.toString());
    }
  }
}
