part of 'transaction_date_time_cubit.dart';

abstract class TransactionDateTimeState extends Equatable {
  const TransactionDateTimeState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionDateTimeState {}

class TransactionDateSelected extends TransactionDateTimeState {
  final String selectedDate;

  const TransactionDateSelected(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

class TransactionTimeSelected extends TransactionDateTimeState {
  final String selectedTime;

  const TransactionTimeSelected(this.selectedTime);

  @override
  List<Object?> get props => [selectedTime];
}
