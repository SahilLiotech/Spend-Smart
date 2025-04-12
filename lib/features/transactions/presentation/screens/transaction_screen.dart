import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spend_smart/core/prefrences/apppref.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/features/transactions/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import '../widgets/custom_transaction_card.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  // Filter options
  String? selectedFilter;
  final List<String> filterOptions = ['All', 'Income', 'Expense'];

  // Sorting options
  String? selectedSort;
  final List<String> sortOptions = [
    'Latest',
    'Oldest',
    'Amount (High to Low)',
    'Amount (Low to High)'
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
          _buildSearchBar(),
          Expanded(
            child: _buildTransactionsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          // Search Bar
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

          const SizedBox(width: 12),

          Container(
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
                setState(() {
                  selectedFilter = (selectedFilter == result) ? null : result;
                });
              },
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              itemBuilder: (BuildContext context) => [
                // Header item (non-selectable)
                PopupMenuItem<String>(
                  enabled: false,
                  child: Column(
                    spacing: 4,
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

                // Filter options
                ...filterOptions.map((String filter) {
                  return PopupMenuItem<String>(
                    value: filter,
                    child: Row(
                      children: [
                        Icon(
                          selectedFilter == filter
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: selectedFilter == filter
                              ? CustomColors.primaryColor
                              : CustomColors.blackColor,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: filter,
                          color: CustomColors.blackColor,
                        ),
                      ],
                    ),
                  );
                }),

                // Sort divider
                PopupMenuItem<String>(
                  enabled: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const CustomText(
                        text: "Sort by:",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.blackColor,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 1,
                        color: CustomColors.hintTextColor,
                      ),
                    ],
                  ),
                ),

                // Sort options as a sub-menu
                PopupMenuItem<String>(
                  enabled: false,
                  child: _buildSortOptionsMenu(),
                ),

                // Reset filters
                PopupMenuItem<String>(
                  enabled: true,
                  value: "reset_filters",
                  onTap: () {
                    setState(() {
                      selectedFilter = null;
                      selectedSort = sortOptions.first;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.refresh,
                        color: CustomColors.primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      const CustomText(
                        text: "Reset All Filters",
                        color: CustomColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOptionsMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortOptions.map((String sortOption) {
        final isSelected = selectedSort == sortOption;
        return InkWell(
          onTap: () {
            setState(() {
              selectedSort = sortOption;
            });
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected
                      ? CustomColors.primaryColor
                      : CustomColors.blackColor,
                  size: 18,
                ),
                const SizedBox(width: 10),
                CustomText(
                  text: sortOption,
                  color: CustomColors.blackColor,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTransactionsList() {
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

          if (selectedFilter != null && selectedFilter != 'All') {
            final filterType = selectedFilter?.toLowerCase() == 'income'
                ? 'income'
                : 'expense';
            filteredTransactions = filteredTransactions
                .where(
                    (transaction) => transaction.transactionType == filterType)
                .toList();
          }

          if (selectedSort != null) {
            switch (selectedSort) {
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
          }

          if (filteredTransactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 80,
                    color: CustomColors.hintTextColor,
                  ),
                  const SizedBox(height: 16),
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
                  onTap: () {
                    // Show transaction details or edit options
                    _showTransactionDetails(transaction);
                  },
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 60,
                  color: CustomColors.expenseColor,
                ),
                const SizedBox(height: 16),
                CustomText(
                  text: "Error: ${state.message}",
                  fontSize: 16,
                  color: CustomColors.expenseColor,
                ),
                const SizedBox(height: 16),
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
  }

  void _showTransactionDetails(dynamic transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Transaction Details",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              _buildDetailRow(
                  "Type",
                  transaction.transactionType == 'income'
                      ? "Income"
                      : "Expense"),
              _buildDetailRow("Amount", "Rs.${transaction.transactionAmount}"),
              _buildDetailRow("Category", transaction.category),
              _buildDetailRow(
                transaction.transactionType == 'income'
                    ? "Received From"
                    : "Paid To",
                transaction.transactionType == 'income'
                    ? transaction.receivedFrom.toString()
                    : transaction.paidTo.toString(),
              ),
              _buildDetailRow("Date",
                  DateFormat('dd/MM/yyyy').format(transaction.transactionDate)),
              _buildDetailRow("Time", transaction.transactionTime),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // Add navigation to edit screen
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text("Delete"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.expenseColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _confirmDeleteTransaction(transaction);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: CustomText(
              text: label,
              fontWeight: FontWeight.w600,
              color: CustomColors.hintTextColor,
            ),
          ),
          Expanded(
            child: CustomText(
              text: value,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteTransaction(dynamic transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Transaction'),
          content: const Text(
              'Are you sure you want to delete this transaction? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: CustomColors.expenseColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<TransactionBloc>().add(
                      DeleteTransactionEvent(
                        AppPref.getUserId(),
                        transaction.id,
                      ),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
