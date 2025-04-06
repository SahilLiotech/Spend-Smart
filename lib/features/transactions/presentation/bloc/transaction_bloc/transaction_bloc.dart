import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spend_smart/features/transactions/domain/usecases/get_transactions_usecase.dart';

import '../../../domain/enitities/transaction_entity.dart';
import '../../../domain/usecases/add_transaction_usecase.dart';
import '../../../domain/usecases/delete_transaction_usecase.dart';
import '../../../domain/usecases/update_transaction_usecase.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final AddTransactionUseCase addTransactionUseCase;
  final UpdateTransactionUsecase updateTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;

  TransactionBloc({
    required this.getTransactionsUseCase,
    required this.addTransactionUseCase,
    required this.updateTransactionUseCase,
    required this.deleteTransactionUseCase,
  }) : super(TransactionInitial()) {
    on<GetTransactionsEvent>(_onGetTransactions);
    on<AddTransactionEvent>(_onAddTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
  }

  Future<void> _onGetTransactions(
    GetTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transactions = await getTransactionsUseCase(
          GetTransactionsParams(userId: event.userId));
      emit(TransactionsLoaded(transactions));
    } catch (e) {
      emit(TransactionError('Failed to load transactions: $e'));
    }
  }

  Future<void> _onAddTransaction(
    AddTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      await addTransactionUseCase(AddTransactionParams(
          userId: event.userId, transaction: event.transaction));
      emit(const TransactionSuccess('Transaction added successfully'));
    } catch (e) {
      emit(TransactionError('Failed to add transaction: $e'));
    }
  }

  Future<void> _onUpdateTransaction(
    UpdateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      await updateTransactionUseCase(
        UpdateTransactionParams(
          userId: event.userId,
          transactionId: event.transactionId,
          transaction: event.updatedTransaction,
        ),
      );
      emit(const TransactionSuccess('Transaction updated successfully'));
    } catch (e) {
      emit(TransactionError('Failed to update transaction: $e'));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      await deleteTransactionUseCase(DeleteTransactionParams(
          userId: event.userId, transactionId: event.transactionId));
      emit(const TransactionSuccess('Transaction deleted successfully'));
    } catch (e) {
      emit(TransactionError('Failed to delete transaction: $e'));
    }
  }
}
