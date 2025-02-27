import 'package:spend_smart/features/category/domain/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> fetchCategory();
}
