import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/core/utils/widgets/transaction_type_cubit.dart';

class Category {
  final int id;
  final String type;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.type,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}

class CustomTransactionBottomSheet extends StatefulWidget {
  const CustomTransactionBottomSheet({super.key});

  @override
  State<CustomTransactionBottomSheet> createState() =>
      _CustomTransactionBottomSheetState();
}

class _CustomTransactionBottomSheetState
    extends State<CustomTransactionBottomSheet> {
  final TextEditingController _incomeAmountController = TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();
  final TextEditingController _receivedFromController = TextEditingController();
  final TextEditingController _paidToController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  final FocusNode _incomeAmountFocusNode = FocusNode();
  final FocusNode _expenseAmountFocusNode = FocusNode();
  final FocusNode _receivedFromFocusNode = FocusNode();
  final FocusNode _paidToFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();
  final FocusNode _tagFocusNode = FocusNode();

  List<Category> categories = [];
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/categories.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> categoriesJson = jsonData['categories'];

      setState(() {
        categories =
            categoriesJson.map((json) => Category.fromJson(json)).toList();
      });
    } catch (e) {
      debugPrint('Error loading categories: $e');
    }
  }

  @override
  void dispose() {
    _incomeAmountController.dispose();
    _expenseAmountController.dispose();
    _receivedFromController.dispose();
    _paidToController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _tagController.dispose();
    _incomeAmountFocusNode.dispose();
    _expenseAmountFocusNode.dispose();
    _receivedFromFocusNode.dispose();
    _paidToFocusNode.dispose();
    _dateFocusNode.dispose();
    _timeFocusNode.dispose();
    _tagFocusNode.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  void showCategoryBottomSheet(
      BuildContext context, TransactionType transactionType) {
    final String type =
        transactionType == TransactionType.income ? 'income' : 'expense';
    final List<Category> filteredCategories =
        categories.where((c) => c.type == type).toList();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        children: [
                          SvgPicture.asset(
                            category.icon,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 12),
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
                          setState(() {
                            selectedCategory = category;
                            _tagController.text = category.name;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                          _tagController.text = category.name;
                        });
                        Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionTypeCubit, TransactionType>(
      builder: (context, state) {
        bool isIncome = state == TransactionType.income;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 15,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: AppString.addIncomeExpense,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context
                          .read<TransactionTypeCubit>()
                          .toggleTransactionType(TransactionType.income),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isIncome
                              ? CustomColors.incomeColor
                              : CustomColors.secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: AppString.income,
                          fontSize: 14,
                          color: isIncome
                              ? CustomColors.whiteColor
                              : CustomColors.blackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context
                          .read<TransactionTypeCubit>()
                          .toggleTransactionType(TransactionType.expense),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !isIncome
                              ? CustomColors.expenseColor
                              : CustomColors.secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: AppString.expense,
                          color: !isIncome ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: isIncome
                    ? _incomeAmountController
                    : _expenseAmountController,
                focusNode:
                    isIncome ? _incomeAmountFocusNode : _expenseAmountFocusNode,
                decoration: InputDecoration(
                  hintText:
                      isIncome ? AppString.enterIncome : AppString.enterExpense,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller:
                    isIncome ? _receivedFromController : _paidToController,
                focusNode: isIncome ? _receivedFromFocusNode : _paidToFocusNode,
                decoration: InputDecoration(
                  hintText:
                      isIncome ? AppString.receivedFrom : AppString.paidTo,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => showCategoryBottomSheet(context, state),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _tagController,
                          focusNode: _tagFocusNode,
                          decoration: InputDecoration(
                            hintText: AppString.addTag,
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                            prefixIcon: selectedCategory != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      selectedCategory!.icon,
                                      width: 20,
                                      height: 20,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => showCategoryBottomSheet(context, state),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: selectDate,
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _dateController,
                          focusNode: _dateFocusNode,
                          decoration: InputDecoration(
                            hintText: "Select Date",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: selectTime,
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _timeController,
                          focusNode: _timeFocusNode,
                          decoration: InputDecoration(
                            hintText: "Select Time",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                            suffixIcon: const Icon(Icons.access_time),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    onTap: () {
                      debugPrint(
                          "SELECTED CATEGORY :::: ${_tagController.text}");
                    },
                    buttonText: AppString.create,
                    buttonRadius: 16,
                    buttonTextSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
