part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<TransactionEntity> transactions;
  final double totalIncome;
  final double totalExpense;
  final double totalBalance;

  const TransactionsLoaded(
    this.transactions, {
    this.totalIncome = 0.0,
    this.totalExpense = 0.0,
    this.totalBalance = 0.0,
  });

  @override
  List<Object> get props =>
      [transactions, totalIncome, totalExpense, totalBalance];
}

class TransactionLoaded extends TransactionState {
  final TransactionEntity transaction;

  const TransactionLoaded(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class TransactionSuccess extends TransactionState {
  final String message;

  const TransactionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}
