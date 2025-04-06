import '../../domain/enitities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_remote_datasource.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TransactionEntity>> getTransactions(String userId) async {
    try {
      return await remoteDataSource.getTransactions(userId);
    } catch (e) {
      throw Exception('Repository: Failed to get transactions: $e');
    }
  }

  @override
  Future<TransactionEntity> getTransaction(
      String userId, String transactionId) async {
    try {
      return await remoteDataSource.getTransaction(userId, transactionId);
    } catch (e) {
      throw Exception('Repository: Failed to get transaction: $e');
    }
  }

  @override
  Future<void> addTransaction(
      String userId, TransactionEntity transaction) async {
    try {
      await remoteDataSource.addTransaction(
          userId, TransactionModel.fromEntity(transaction));
    } catch (e) {
      throw Exception('Repository: Failed to add transaction: $e');
    }
  }

  @override
  Future<void> updateTransaction(String userId, String transactionId,
      TransactionEntity transaction) async {
    try {
      await remoteDataSource.updateTransaction(
          userId, TransactionModel.fromEntity(transaction));
    } catch (e) {
      throw Exception('Repository: Failed to update transaction: $e');
    }
  }

  @override
  Future<void> deleteTransaction(String userId, String transactionId) async {
    try {
      await remoteDataSource.deleteTransaction(userId, transactionId);
    } catch (e) {
      throw Exception('Repository: Failed to delete transaction: $e');
    }
  }
}
