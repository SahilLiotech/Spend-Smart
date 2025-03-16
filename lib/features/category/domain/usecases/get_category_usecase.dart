import 'package:spend_smart/features/category/domain/entities/category_entity.dart';
import 'package:spend_smart/features/category/domain/repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<List<CategoryEntity>> call() async {
    return await repository.fetchCategory();
  }
}
