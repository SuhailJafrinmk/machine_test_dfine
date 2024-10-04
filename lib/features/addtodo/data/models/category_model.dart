class CategoryModel {
  final int? id;
  final String categoryName;
  final DateTime createdAt;

  CategoryModel({
    this.id,
    required this.categoryName,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryName': categoryName,
      'createdAt': createdAt.toIso8601String(), 
    };
  }


  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      categoryName: map['categoryName'] ?? '',
      createdAt: DateTime.parse(map['createdAt']), 
    );
  }
}
