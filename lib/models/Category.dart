import 'package:expenses_tracker/constands/local_database.dart';

class Category {
  final String name;
  final int id;

  Category({required this.name, required this.id});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(name: map[categoryName], id: map[categoryId]);
  }
}
