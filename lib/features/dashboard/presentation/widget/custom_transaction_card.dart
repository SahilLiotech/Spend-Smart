import 'package:flutter/material.dart';

import '../../../../core/utils/custom_colors.dart';
import '../../../../core/utils/widgets/custom_text_widget.dart';

class TransactionCard extends StatelessWidget {
  final String companyName;
  final String date;
  final String category;
  final String amount;
  final bool isIncome;
  final VoidCallback onTap;

  const TransactionCard(
      {super.key,
      required this.companyName,
      required this.date,
      required this.category,
      required this.amount,
      this.isIncome = true,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: CustomColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
              color: isIncome
                  ? CustomColors.incomeColor
                  : CustomColors.expenseColor,
              width: 6,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColors.hintTextColor.withValues(),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: companyName,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: CustomColors.blackColor,
                ),
                CustomText(
                  text: date,
                  fontSize: 14,
                  color: CustomColors.hintTextColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: category,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: CustomColors.transactionCategoryColor,
                ),
                CustomText(
                  text: (isIncome ? "+" : "-") + amount,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isIncome
                      ? CustomColors.incomeColor
                      : CustomColors.expenseColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
