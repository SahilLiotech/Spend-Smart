import '../enitities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntity>> getTransactions(String userId);
  Future<TransactionEntity> getTransaction(String userId, String transactionId);
  Future<void> addTransaction(String userId, TransactionEntity transaction);
  Future<void> updateTransaction(
      String userId, String transactionId, TransactionEntity transaction);
  Future<void> deleteTransaction(String userId, String transactionId);
}
