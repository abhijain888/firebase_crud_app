import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String task, desc;
  final dynamic createdAt;
  const DetailScreen(
      {super.key, required this.task, required this.desc, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Task: $task"),
              Text("Description: $desc"),
              Text("createdAt: ${createdAt.toString()}"),
            ],
          ),
        ],
      ),
    );
  }
}
