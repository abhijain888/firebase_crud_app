import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  String id;
  String? todo;
  String? description;
  dynamic createdAt;
  bool? isCompleted;
  Task({
    this.id = "",
    this.todo,
    this.description,
    this.createdAt,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? todo,
    String? description,
    dynamic createdAt,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'description': description,
      'createdAt': createdAt,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      todo: map['todo'] != null ? map['todo'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] as dynamic,
      isCompleted:
          map['isCompleted'] != null ? map['isCompleted'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, todo: $todo, description: $description, createdAt: $createdAt, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.todo == todo &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        todo.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        isCompleted.hashCode;
  }
}
