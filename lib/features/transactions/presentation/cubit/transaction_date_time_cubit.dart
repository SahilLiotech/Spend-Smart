import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
part 'transaction_date_time_state.dart';

class TransactionDateTimeCubit extends Cubit<TransactionDateTimeState> {
  TransactionDateTimeCubit() : super(TransactionInitial());

  void selectDate(DateTime date) {
    emit(TransactionDateSelected(DateFormat('dd/MM/yyyy').format(date)));
  }

  void selectTime(TimeOfDay time) {
    final formattedTime = "${time.hour}:${time.minute}";
    emit(TransactionTimeSelected(formattedTime));
  }
}
