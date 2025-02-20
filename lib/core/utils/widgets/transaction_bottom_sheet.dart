import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/core/utils/widgets/transaction_type_cubit.dart';

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

  @override
  void dispose() {
    _incomeAmountController.dispose();
    _expenseAmountController.dispose();
    _receivedFromController.dispose();
    _paidToController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
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

  Future<void> _selectTime() async {
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
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
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

              const SizedBox(height: 5),

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

              const SizedBox(height: 2),

              TextField(
                controller: isIncome
                    ? _incomeAmountController
                    : _expenseAmountController,
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
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: AppString.addTag,
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ],
              ),

              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _selectDate,
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _dateController,
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
                      onTap: _selectTime,
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _timeController,
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

              const SizedBox(height: 5),

              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  onTap: () {
                    // Handle create button action
                  },
                  buttonText: AppString.create,
                  buttonRadius: 16,
                  buttonTextSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
