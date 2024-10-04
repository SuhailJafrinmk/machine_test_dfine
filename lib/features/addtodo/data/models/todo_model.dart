class TodoModel {
  final String title;
  final String? description;
  final DateTime createdAt;

  TodoModel({
    required this.title,
    this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(), 
    };
  }


  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),  
    );
  }
}
