import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/core/utils/widgets/transaction_type_cubit.dart';
import 'package:spend_smart/features/category/domain/category_entity.dart';
import 'package:spend_smart/features/category/presentation/cubit/category_cubit.dart';

class CategoryBottomSheet extends StatelessWidget {
  final TransactionType transactionType;
  final Function(CategoryEntity) onCategorySelected;
  final CategoryEntity? selectedCategory;

  const CategoryBottomSheet({
    super.key,
    required this.transactionType,
    required this.onCategorySelected,
    this.selectedCategory,
  });

  void _selectCategory(BuildContext context, CategoryEntity category) {
    onCategorySelected(category);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final String type =
        transactionType == TransactionType.income ? 'income' : 'expense';

    return BlocBuilder<CategoryCubit, List<CategoryEntity>>(
      builder: (context, state) {
        final List<CategoryEntity> filteredCategories =
            state.where((c) => c.type == type).toList();

        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              CustomText(
                text: "Select $type Category",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: CustomColors.blackColor,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    return ListTile(
                      title: Row(
                        spacing: 10,
                        children: [
                          SvgPicture.asset(
                            category.icon,
                            width: 24,
                            height: 24,
                          ),
                          CustomText(
                            text: category.name,
                            color: CustomColors.blackColor,
                          ),
                        ],
                      ),
                      trailing: Radio<int>(
                        value: category.id,
                        groupValue: selectedCategory?.id,
                        onChanged: (int? value) {
                          _selectCategory(context, category);
                        },
                      ),
                      onTap: () {
                        _selectCategory(context, category);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
