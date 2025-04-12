part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionsEvent extends TransactionEvent {
  final String userId;

  const GetTransactionsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AddTransactionEvent extends TransactionEvent {
  final String userId;
  final TransactionEntity transaction;

  const AddTransactionEvent({required this.userId, required this.transaction});

  @override
  List<Object> get props => [userId, transaction];
}

class UpdateTransactionEvent extends TransactionEvent {
  final String userId;
  final String transactionId;
  final TransactionEntity updatedTransaction;

  const UpdateTransactionEvent(
      this.userId, this.transactionId, this.updatedTransaction);

  @override
  List<Object> get props => [userId, transactionId, updatedTransaction];
}

class DeleteTransactionEvent extends TransactionEvent {
  final String userId;
  final String transactionId;

  const DeleteTransactionEvent(this.userId, this.transactionId);

  @override
  List<Object> get props => [userId, transactionId];
}
