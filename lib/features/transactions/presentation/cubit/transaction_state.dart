part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionDateSelected extends TransactionState {
  final String selectedDate;

  const TransactionDateSelected(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

class TransactionTimeSelected extends TransactionState {
  final String selectedTime;

  const TransactionTimeSelected(this.selectedTime);

  @override
  List<Object?> get props => [selectedTime];
}
