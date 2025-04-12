import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:spend_smart/config/routes/routes.dart';
import 'package:spend_smart/core/prefrences/apppref.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/features/auth/presentation/bloc/login_bloc/login_bloc.dart';

import '../../../transactions/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import '../widget/custom_transaction_card.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    final userId = AppPref.getUserId();
    context.read<TransactionBloc>().add(GetTransactionsEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionSuccess) {
          // Refresh the transactions when a transaction is added successfully
          _loadTransactions();
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.secondaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              spacing: 5,
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        _buildHeader(),
                        _buildDashboardContainer(width, height),
                        CustomText(
                          text: AppString.recentTransaction,
                          color: CustomColors.blackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        BlocBuilder<TransactionBloc, TransactionState>(
                          builder: (context, state) {
                            if (state is TransactionLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is TransactionsLoaded) {
                              final latestFiveTransactions = state.transactions
                                  .toList()
                                ..sort((a, b) => b.transactionDate
                                    .compareTo(a.transactionDate));
                              final lastFiveTransactions =
                                  latestFiveTransactions.take(5).toList();

                              return Column(
                                children: lastFiveTransactions
                                    .map((transaction) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: TransactionCard(
                                            onTap: () {},
                                            companyName: transaction
                                                        .transactionType ==
                                                    'income'
                                                ? transaction.receivedFrom
                                                    .toString()
                                                : transaction.paidTo.toString(),
                                            date: DateFormat('dd/MM/yyyy')
                                                .format(transaction
                                                    .transactionDate),
                                            category: transaction.category,
                                            amount: transaction
                                                .transactionAmount
                                                .toString(),
                                            isIncome:
                                                transaction.transactionType ==
                                                    'income',
                                          ),
                                        ))
                                    .toList(),
                              );
                            } else if (state is TransactionError) {
                              return Center(child: Text(state.message));
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContainer(double width, double height) {
    return Container(
      height: 310,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CustomColors.dashBoardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppString.dashboard,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 5),
          _buildMainContainer(width, height),
          _buildRowContainers(width, height),
        ],
      ),
    );
  }

  Widget _buildMainContainer(double width, double height) {
    return Container(
        padding: EdgeInsets.all(16),
        height: 105,
        decoration: BoxDecoration(
          color: CustomColors.dashBoardContainerColor,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: CustomColors.whiteColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppString.totalBalance,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                BlocBuilder<TransactionBloc, TransactionState>(
                    builder: (context, state) {
                  String balanceAmount = "Rs.0";

                  if (state is TransactionsLoaded) {
                    balanceAmount =
                        "Rs.${state.totalBalance.toStringAsFixed(2)}";
                  }
                  return CustomText(
                    text: balanceAmount,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  );
                })
              ],
            ),
            SvgPicture.asset("assets/images/wallet_icon.svg"),
          ],
        ));
  }

  Widget _buildRowContainers(double width, double height) {
    return BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
      String incomeAmount = "Rs.0";
      String expenseAmount = "Rs.0";

      if (state is TransactionsLoaded) {
        incomeAmount = "Rs.${state.totalIncome.toStringAsFixed(2)}";
        expenseAmount = "Rs.${state.totalExpense.toStringAsFixed(2)}";
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSingleContainer(width, height, CustomColors.incomeColor,
              AppString.income, incomeAmount),
          _buildSingleContainer(width, height, CustomColors.expenseColor,
              AppString.expense, expenseAmount),
        ],
      );
    });
  }

  Widget _buildSingleContainer(double width, double height, Color textColor,
      String text, String amount) {
    return Container(
      padding: EdgeInsets.all(16),
      width: width * 0.41,
      height: 105,
      decoration: BoxDecoration(
          color: CustomColors.dashBoardContainerColor,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: CustomColors.whiteColor)),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: text,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          CustomText(
            text: amount,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: textColor,
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "${AppString.hello} ${AppPref.getUserName()}",
              color: CustomColors.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text: DateFormat('MMM dd, yyyy').format(DateTime.now()),
              color: CustomColors.blackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context.read<LoginBloc>().add(LogoutEvent());
                Navigator.pushReplacementNamed(context, Routes.login);
              },
              child: SvgPicture.asset('assets/images/profile_icon.svg'),
            );
          },
        ),
      ],
    );
  }
}
