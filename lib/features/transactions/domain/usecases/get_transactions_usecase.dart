import '../../../../core/usecases/usecase.dart';
import '../enitities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionsUseCase
    extends UseCase<List<TransactionEntity>, GetTransactionsParams> {
  final TransactionRepository repository;

  GetTransactionsUseCase({required this.repository});

  @override
  Future<List<TransactionEntity>> call(GetTransactionsParams params) async {
    return await repository.getTransactions(params.userId);
  }
}

class GetTransactionsParams {
  final String userId;

  GetTransactionsParams({required this.userId});
}
