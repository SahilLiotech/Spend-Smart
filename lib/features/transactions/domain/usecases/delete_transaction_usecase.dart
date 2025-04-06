import '../../../../core/usecases/usecase.dart';
import '../repositories/transaction_repository.dart';

class DeleteTransactionUseCase extends UseCase<void, DeleteTransactionParams> {
  final TransactionRepository repository;

  DeleteTransactionUseCase({required this.repository});

  @override
  Future<void> call(DeleteTransactionParams params) async {
    await repository.deleteTransaction(params.userId, params.transactionId);
  }
}

class DeleteTransactionParams {
  final String userId;
  final String transactionId;

  DeleteTransactionParams({required this.userId, required this.transactionId});
}
