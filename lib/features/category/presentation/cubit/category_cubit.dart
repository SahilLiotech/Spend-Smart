import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_smart/features/category/domain/entities/category_entity.dart';
import 'package:spend_smart/features/category/domain/usecases/get_category_usecase.dart';

class CategoryCubit extends Cubit<List<CategoryEntity>> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryCubit({required this.getCategoriesUseCase}) : super([]);

  Future<void> loadCategories() async {
    try {
      final categories = await getCategoriesUseCase();
      emit(categories);
    } catch (e) {
      emit([]);
    }
  }
}
