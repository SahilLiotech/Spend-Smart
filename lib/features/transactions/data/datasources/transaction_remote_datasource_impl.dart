import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spend_smart/features/transactions/data/datasources/transaction_remote_datasource.dart';

import '../../../../core/services/firebase_service.dart';
import '../models/transaction_model.dart';

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final FirebaseService firebaseService;
  TransactionRemoteDataSourceImpl({required this.firebaseService});
  FirebaseFirestore get firestore => firebaseService.firestore;

  @override
  Future<List<TransactionModel>> getTransactions(String userId) async {
    try {
      final transactionCollection = await firestore
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .get();

      return transactionCollection.docs
          .map((doc) => TransactionModel.fromJson({
                'id': doc.id,
                ...doc.data(),
              }))
          .toList();
    } catch (e) {
      throw Exception('Failed to get transactions: $e');
    }
  }

  @override
  Future<TransactionModel> getTransaction(
      String userId, String transactionId) async {
    try {
      final transactionDoc = await firestore
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .doc(transactionId)
          .get();

      if (!transactionDoc.exists) {
        throw Exception('Transaction not found');
      }

      return TransactionModel.fromJson({
        'id': transactionDoc.id,
        ...transactionDoc.data()!,
      });
    } catch (e) {
      throw Exception('Failed to get transaction: $e');
    }
  }

  @override
  Future<void> addTransaction(
      String userId, TransactionModel transaction) async {
    try {
      final docRef = await firestore
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .add(transaction.toJson());

      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('Failed to add transaction: $e');
    }
  }

  @override
  Future<void> updateTransaction(
    String userId,
    TransactionModel transaction,
  ) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .doc(transaction.id)
          .update(transaction.toJson());
    } catch (e) {
      throw Exception('Failed to update transaction: $e');
    }
  }

  @override
  Future<void> deleteTransaction(String userId, String transactionId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .doc(transactionId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete transaction: $e');
    }
  }
}
