import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/features/transactions/presentation/bloc/transaction_type_cubit.dart';
import 'package:spend_smart/features/category/domain/entities/category_entity.dart';
import 'package:spend_smart/features/category/presentation/cubit/category_cubit.dart';

class CategoryBottomSheet extends StatefulWidget {
  final TransactionType transactionType;
  final Function(CategoryEntity) onCategorySelected;
  final CategoryEntity? selectedCategory;

  const CategoryBottomSheet({
    super.key,
    required this.transactionType,
    required this.onCategorySelected,
    this.selectedCategory,
  });

  @override
  State<CategoryBottomSheet> createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _selectCategory(BuildContext context, CategoryEntity category) {
    widget.onCategorySelected(category);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().loadCategories();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String type =
        widget.transactionType == TransactionType.income ? 'income' : 'expense';

    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Select $type Category",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: CustomColors.blackColor,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/images/dialog_close_icon.svg",
                ),
              )
            ],
          ),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search categories...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          BlocBuilder<CategoryCubit, List<CategoryEntity>>(
            builder: (context, state) {
              if (state.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final List<CategoryEntity> filteredCategories = state.where((c) {
                return c.type == type &&
                    (_searchQuery.isEmpty ||
                        c.name.toLowerCase().contains(_searchQuery));
              }).toList();

              if (filteredCategories.isEmpty && _searchQuery.isNotEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text("No categories match your search"),
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  itemCount: filteredCategories.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    final isSelected =
                        widget.selectedCategory?.id == category.id;

                    return ListTile(
                      title: Row(
                        spacing: 10,
                        children: [
                          SvgPicture.asset(
                            category.icon,
                            width: 24,
                            height: 24,
                            colorFilter: isSelected
                                ? ColorFilter.mode(
                                    type == 'income'
                                        ? CustomColors.incomeColor
                                        : CustomColors.expenseColor,
                                    BlendMode.srcIn)
                                : null,
                          ),
                          CustomText(
                            text: category.name,
                            color: CustomColors.blackColor,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ],
                      ),
                      trailing: Radio<int>(
                        value: category.id,
                        groupValue: widget.selectedCategory?.id,
                        activeColor: type == 'income'
                            ? CustomColors.incomeColor
                            : CustomColors.expenseColor,
                        onChanged: (int? value) {
                          _selectCategory(context, category);
                        },
                      ),
                      onTap: () {
                        _selectCategory(context, category);
                      },
                      tileColor: isSelected
                          ? (type == 'income'
                              ? CustomColors.incomeColor
                              : CustomColors.expenseColor)
                          : null,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
