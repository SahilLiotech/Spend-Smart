import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:spend_smart/core/error/exception.dart';
import 'package:spend_smart/features/category/data/category_model.dart';
import 'package:spend_smart/features/category/domain/category_entity.dart';
import 'package:spend_smart/features/category/domain/category_repository.dart';

class CategoryRepositoryImp extends CategoryRepository {
  @override
  Future<List<CategoryEntity>> fetchCategory() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/images/data/categories.json');

      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      final List<dynamic> categoryData = jsonData['categories'];

      return categoryData
          .map((e) => CategoryModel.fromJson(e).toEntity())
          .toList();
    } catch (e) {
      throw ErrorException(e.toString());
    }
  }
}
