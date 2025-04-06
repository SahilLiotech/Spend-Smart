class TransactionEntity {
  final String? id;
  final String category;
  final String transactionType;
  final double transactionAmount;
  final String? paidTo;
  final String? receivedFrom;
  final DateTime transactionDate;
  final String transactionTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransactionEntity({
    this.id,
    required this.category,
    required this.transactionType,
    required this.transactionAmount,
    this.paidTo,
    this.receivedFrom,
    required this.transactionDate,
    required this.transactionTime,
    required this.createdAt,
    required this.updatedAt,
  });
}
