class TodoModel {

  TodoModel({
    required this.id,
    required this.text,
    required this.done,

  });

  final String id;
  final String text;
  final bool done;


  static TodoModel fromJson(Map<String, dynamic> todoData) {
    return TodoModel(
      id: todoData['id'],
      text: todoData['text'],
      done: todoData['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : this.id,
      'text' : this.text,
      'done' : this.done,
    };
  }
}