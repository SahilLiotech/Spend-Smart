import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spend_smart/core/utils/string.dart';

part 'transaction_filter_state.dart';

class TransactionFilterCubit extends Cubit<TransactionFilterState> {
  TransactionFilterCubit()
      : super(TransactionFilterState(
            selectedFilter: AppString.all, selectedSort: AppString.latest));

  void setFilter(String? filter) {
    emit(state.copyWith(selectedFilter: filter));
  }

  void setSort(String sort) {
    emit(state.copyWith(selectedSort: sort));
  }

  void resetFilters() {
    emit(const TransactionFilterState(
      selectedFilter: AppString.all,
      selectedSort: AppString.latest,
    ));
  }
}
