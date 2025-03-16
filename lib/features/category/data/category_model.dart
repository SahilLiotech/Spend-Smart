import 'package:spend_smart/features/category/domain/entities/category_entity.dart';

class CategoryModel {
  final int id;
  final String type;
  final String name;
  final String icon;

  CategoryModel({
    required this.id,
    required this.type,
    required this.name,
    required this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      type: type,
      name: name,
      icon: icon,
    );
  }
}
