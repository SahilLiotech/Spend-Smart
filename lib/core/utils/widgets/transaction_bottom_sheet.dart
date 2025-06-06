import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spend_smart/core/prefrences/apppref.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/date_time_format_helper.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/widgets/category_bottom_sheet.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/core/utils/widgets/custom_toast.dart';
import 'package:spend_smart/core/validator/transaction_validator.dart';
import 'package:spend_smart/features/transactions/presentation/cubit/transaction_type_cubit.dart';
import 'package:spend_smart/features/category/domain/entities/category_entity.dart';
import 'package:spend_smart/features/transactions/presentation/cubit/transaction_date_time_cubit.dart'
    as transaction_cubit;
import '../../../features/transactions/domain/enitities/transaction_entity.dart';
import '../../../features/transactions/presentation/bloc/transaction_bloc/transaction_bloc.dart';

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

  final _formKey = GlobalKey<FormState>();
  CategoryEntity? selectedCategory;

  @override
  void initState() {
    super.initState();
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
    final ctx = context;
    DateTime? picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (!ctx.mounted) return;
      ctx.read<transaction_cubit.TransactionDateTimeCubit>().selectDate(picked);
      setState(() {
        _dateController.text = TransactionDateTimeHelper.formatDate(picked);
      });
    }
  }

  Future<void> selectTime() async {
    final ctx = context;
    TimeOfDay? picked = await showTimePicker(
      context: ctx,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      if (!ctx.mounted) return;
      ctx.read<transaction_cubit.TransactionDateTimeCubit>().selectTime(picked);
      setState(() {
        _timeController.text =
            TransactionDateTimeHelper.formatTime(picked, ctx);
      });
    }
  }

  void showCategoryBottomSheet(
      BuildContext context, TransactionType transactionType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return CategoryBottomSheet(
          transactionType: transactionType,
          selectedCategory: selectedCategory,
          onCategorySelected: (category) {
            setState(() {
              selectedCategory = category;
              _tagController.text = category.name;
            });
          },
        );
      },
    );
  }

  void _submitTransaction() {
    if (!_formKey.currentState!.validate()) return;

    final transactionType = context.read<TransactionTypeCubit>().state;
    final isIncome = transactionType == TransactionType.income;

    final completeDateTime = TransactionDateTimeHelper.combineDateTime(
      _dateController.text,
      _timeController.text,
    );

    final transaction = TransactionEntity(
      category: selectedCategory?.name ?? 'Uncategorized',
      transactionType: isIncome ? 'income' : 'expense',
      transactionAmount: isIncome
          ? double.parse(_incomeAmountController.text)
          : double.parse(_expenseAmountController.text),
      paidTo: isIncome ? null : _paidToController.text,
      receivedFrom: isIncome ? _receivedFromController.text : null,
      transactionDate: completeDateTime,
      transactionTime: _timeController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    context.read<TransactionBloc>().add(
          AddTransactionEvent(
            userId: AppPref.getUserId().toString(),
            transaction: transaction,
          ),
        );

    CustomToast.showSuccess(
        context, "Success", "Transaction added successfully");

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionTypeCubit, TransactionType>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isIncome = state == TransactionType.income;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: isIncome
                      ? _incomeAmountController
                      : _expenseAmountController,
                  focusNode: isIncome
                      ? _incomeAmountFocusNode
                      : _expenseAmountFocusNode,
                  decoration: InputDecoration(
                    hintText: isIncome
                        ? AppString.enterIncome
                        : AppString.enterExpense,
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      TransactionValidator.validateAmount(value),
                ),
                TextFormField(
                  controller:
                      isIncome ? _receivedFromController : _paidToController,
                  focusNode:
                      isIncome ? _receivedFromFocusNode : _paidToFocusNode,
                  decoration: InputDecoration(
                    hintText:
                        isIncome ? AppString.receivedFrom : AppString.paidTo,
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) =>
                      TransactionValidator.validateSource(value, isIncome),
                ),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showCategoryBottomSheet(context, state);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
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
                            validator: (value) =>
                                TransactionValidator.validateCategory(value),
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
                Row(spacing: 10, children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: selectDate,
                      child: AbsorbPointer(
                        child: TextFormField(
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
                          validator: (value) =>
                              TransactionValidator.validateDate(value),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: selectTime,
                      child: AbsorbPointer(
                        child: TextFormField(
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
                          validator: (value) =>
                              TransactionValidator.validateTime(value),
                        ),
                      ),
                    ),
                  ),
                ]),
                BlocConsumer<TransactionBloc, TransactionState>(
                  listener: (context, state) {
                    if (state is TransactionError) {
                      CustomToast.showFailure(
                          context, "Failure", state.message);
                    }
                    if (state is TransactionSuccess) {
                      CustomToast.showSuccess(
                          context, "Success", state.message);
                    }
                  },
                  builder: (context, transactionState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ButtonWidget(
                          isLoading: transactionState is TransactionLoading,
                          buttonText: AppString.create,
                          buttonRadius: 16,
                          buttonTextSize: 16,
                          onTap: () {
                            _submitTransaction();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
