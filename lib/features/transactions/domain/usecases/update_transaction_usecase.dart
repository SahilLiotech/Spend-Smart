import 'package:spend_smart/core/usecases/usecase.dart';
import 'package:spend_smart/features/transactions/domain/enitities/transaction_entity.dart';

import '../repositories/transaction_repository.dart';

class UpdateTransactionUsecase extends UseCase<void, UpdateTransactionParams> {
  final TransactionRepository repository;
  UpdateTransactionUsecase({required this.repository});
  @override
  Future<void> call(UpdateTransactionParams params) async {
    return await repository.updateTransaction(
        params.userId, params.transactionId, params.transaction);
  }
}

class UpdateTransactionParams {
  final String userId;
  final String transactionId;
  final TransactionEntity transaction;

  UpdateTransactionParams(
      {required this.userId,
      required this.transactionId,
      required this.transaction});
}
