import 'package:bloc/bloc.dart';
import 'package:spend_smart/features/category/domain/category_entity.dart';
import 'package:spend_smart/features/category/domain/category_repository.dart';

class CategoryCubit extends Cubit<List<CategoryEntity>> {
  final CategoryRepository categoryRepository;
  CategoryCubit({required this.categoryRepository}) : super([]);
  Future<void> loadData() async {
    try {
      final categories = await categoryRepository.fetchCategory();
      emit(categories);
    } catch (e) {
      emit([]);
    }
  }
}
