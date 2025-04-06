import '../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions(String userId);
  Future<TransactionModel> getTransaction(String userId, String transactionId);
  Future<void> addTransaction(String userId, TransactionModel transaction);
  Future<void> updateTransaction(String userId, TransactionModel transaction);
  Future<void> deleteTransaction(String userId, String transactionId);
}
