import 'package:flutter_bloc/flutter_bloc.dart';

enum TransactionType { income, expense }

class TransactionTypeCubit extends Cubit<TransactionType> {
  TransactionTypeCubit() : super(TransactionType.income);

  void toggleTransactionType(TransactionType type) {
    emit(type);
  }
}
