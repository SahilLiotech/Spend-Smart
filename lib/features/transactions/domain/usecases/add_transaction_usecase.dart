import '../../../../core/usecases/usecase.dart';
import '../enitities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class AddTransactionUseCase extends UseCase<void, AddTransactionParams> {
  final TransactionRepository repository;

  AddTransactionUseCase({required this.repository});

  @override
  Future<void> call(AddTransactionParams params) async {
    await repository.addTransaction(params.userId, params.transaction);
  }
}

class AddTransactionParams {
  final String userId;
  final TransactionEntity transaction;

  AddTransactionParams({required this.userId, required this.transaction});
}
