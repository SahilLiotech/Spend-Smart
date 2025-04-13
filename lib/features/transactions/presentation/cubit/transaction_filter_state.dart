part of 'transaction_filter_cubit.dart';

class TransactionFilterState extends Equatable {
  final String? selectedFilter;
  final String selectedSort;

  const TransactionFilterState({
    required this.selectedFilter,
    required this.selectedSort,
  });

  TransactionFilterState copyWith({
    String? selectedFilter,
    String? selectedSort,
  }) {
    return TransactionFilterState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedSort: selectedSort ?? this.selectedSort,
    );
  }

  @override
  List<Object?> get props => [selectedFilter, selectedSort];
}
