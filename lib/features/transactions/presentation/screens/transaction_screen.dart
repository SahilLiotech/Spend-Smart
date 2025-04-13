import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spend_smart/core/prefrences/apppref.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/features/transactions/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import '../cubit/transaction_filter_cubit.dart';
import '../widgets/custom_transaction_card.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<String> filterOptions = [
    AppString.all,
    AppString.income,
    AppString.expense
  ];

  final List<String> sortOptions = [
    AppString.latest,
    AppString.oldest,
    AppString.amountHightoLow,
    AppString.amountLowtoHigh
  ];

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TransactionFilterCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: CustomColors.secondaryColor,
          appBar: AppBar(
            centerTitle: true,
            title: const CustomText(
              text: AppString.transacations,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
            backgroundColor: CustomColors.secondaryColor,
            elevation: 0,
          ),
          body: Column(
            children: [
              _buildSearchBarAndFilter(context),
              Expanded(
                child: _buildTransactionsList(context),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSearchBarAndFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        spacing: 12,
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: CustomColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.hintTextColor,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  hintText: AppString.searchTransaction,
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          BlocBuilder<TransactionFilterCubit, TransactionFilterState>(
            builder: (context, filterState) {
              return Container(
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.hintTextColor,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.filter_list_alt,
                    color: CustomColors.blackColor,
                  ),
                  onSelected: (String result) {
                    if (filterOptions.contains(result)) {
                      final cubit = context.read<TransactionFilterCubit>();
                      final currentFilter = filterState.selectedFilter;
                      cubit.setFilter(currentFilter == result ? null : result);
                    } else if (result == "reset_filters") {
                      context.read<TransactionFilterCubit>().resetFilters();
                    }
                  },
                  offset: const Offset(0, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      enabled: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: "Filter by:",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.blackColor,
                          ),
                          Container(
                            height: 1,
                            color: CustomColors.hintTextColor,
                          ),
                        ],
                      ),
                    ),

                    ...filterOptions.map((String filter) {
                      return PopupMenuItem<String>(
                        value: filter,
                        child: Row(
                          spacing: 10,
                          children: [
                            Icon(
                              filterState.selectedFilter == filter
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: filterState.selectedFilter == filter
                                  ? CustomColors.primaryColor
                                  : CustomColors.blackColor,
                              size: 18,
                            ),
                            CustomText(
                              text: filter,
                              color: CustomColors.blackColor,
                            ),
                          ],
                        ),
                      );
                    }),

                    PopupMenuItem<String>(
                      enabled: false,
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const CustomText(
                            text: AppString.sortyBy,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.blackColor,
                          ),
                          Container(
                            height: 1,
                            color: CustomColors.hintTextColor,
                          ),
                        ],
                      ),
                    ),

                    // Sort options - fixed as direct menu items now
                    ...sortOptions.map((String sortOption) {
                      return PopupMenuItem<String>(
                        value: sortOption,
                        onTap: () {
                          context
                              .read<TransactionFilterCubit>()
                              .setSort(sortOption);
                        },
                        child: Row(
                          spacing: 10,
                          children: [
                            Icon(
                              filterState.selectedSort == sortOption
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: filterState.selectedSort == sortOption
                                  ? CustomColors.primaryColor
                                  : CustomColors.blackColor,
                              size: 18,
                            ),
                            CustomText(
                              text: sortOption,
                              color: CustomColors.blackColor,
                            ),
                          ],
                        ),
                      );
                    }),

                    // Reset filters
                    PopupMenuItem<String>(
                      value: AppString.resetAllFilter,
                      child: Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.refresh,
                            color: CustomColors.primaryColor,
                            size: 18,
                          ),
                          const CustomText(
                            text: AppString.resetAllFilter,
                            color: CustomColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(BuildContext context) {
    return BlocBuilder<TransactionFilterCubit, TransactionFilterState>(
      builder: (context, filterState) {
        return BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionSuccess) {
              _loadTransactions();
            }
          },
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionsLoaded) {
              var filteredTransactions = state.transactions.toList();

              if (filterState.selectedFilter != null &&
                  filterState.selectedFilter != 'All') {
                final filterType =
                    filterState.selectedFilter?.toLowerCase() == 'income'
                        ? 'income'
                        : 'expense';
                filteredTransactions = filteredTransactions
                    .where((transaction) =>
                        transaction.transactionType == filterType)
                    .toList();
              }

              switch (filterState.selectedSort) {
                case 'Latest':
                  filteredTransactions.sort(
                      (a, b) => b.transactionDate.compareTo(a.transactionDate));
                  break;
                case 'Oldest':
                  filteredTransactions.sort(
                      (a, b) => a.transactionDate.compareTo(b.transactionDate));
                  break;
                case 'Amount (High to Low)':
                  filteredTransactions.sort((a, b) =>
                      b.transactionAmount.compareTo(a.transactionAmount));
                  break;
                case 'Amount (Low to High)':
                  filteredTransactions.sort((a, b) =>
                      a.transactionAmount.compareTo(b.transactionAmount));
                  break;
              }

              if (filteredTransactions.isEmpty) {
                return Center(
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long,
                        size: 80,
                        color: CustomColors.hintTextColor,
                      ),
                      CustomText(
                        text: "No transactions found",
                        fontSize: 18,
                        color: CustomColors.hintTextColor,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TransactionCard(
                      onTap: () {},
                      companyName: transaction.transactionType == 'income'
                          ? transaction.receivedFrom.toString()
                          : transaction.paidTo.toString(),
                      date: DateFormat('dd/MM/yyyy')
                          .format(transaction.transactionDate),
                      category: transaction.category,
                      amount: transaction.transactionAmount.toString(),
                      isIncome: transaction.transactionType == 'income',
                    ),
                  );
                },
              );
            } else if (state is TransactionError) {
              return Center(
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: CustomColors.expenseColor,
                    ),
                    CustomText(
                      text: "Error: ${state.message}",
                      fontSize: 16,
                      color: CustomColors.expenseColor,
                    ),
                    ElevatedButton(
                      onPressed: _loadTransactions,
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("No transactions available"));
            }
          },
        );
      },
    );
  }
}
