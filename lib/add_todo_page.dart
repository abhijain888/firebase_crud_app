import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/task_model.dart';
import 'package:firebase_crud/util.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final controller = TextEditingController();
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
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Write your task here",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => addTask(
                context,
                controller.text,
              ),
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }

  void addTask(
    BuildContext context,
    String todo,
  ) async {
    try {
      print(todo);
      var doc = FirebaseFirestore.instance.collection("tasks").doc();

      var task = Task(
        id: doc.id,
        todo: todo,
      );

      await doc.set(task.toMap());
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
