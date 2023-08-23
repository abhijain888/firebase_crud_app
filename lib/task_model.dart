import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  String id;
  String? todo;
  bool? isCompleted;
  Task({
    this.id = "",
    this.todo,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? todo,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      todo: map['todo'] != null ? map['todo'] as String : null,
      isCompleted:
          map['isCompleted'] != null ? map['isCompleted'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Task(id: $id, todo: $todo, isCompleted: $isCompleted)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.todo == todo &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => id.hashCode ^ todo.hashCode ^ isCompleted.hashCode;
}
