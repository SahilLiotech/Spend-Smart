import '../../domain/enitities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    super.id,
    required super.category,
    required super.transactionType,
    required super.transactionAmount,
    super.paidTo,
    super.receivedFrom,
    required super.transactionDate,
    required super.transactionTime,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      category: json['category'],
      transactionType: json['transaction_type'],
      transactionAmount: json['transaction_amount'].toDouble(),
      paidTo: json['paid_to'],
      receivedFrom: json['received_from'],
      transactionDate: DateTime.parse(json['transaction_date']),
      transactionTime: json['transaction_time'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'transaction_type': transactionType,
      'transaction_amount': transactionAmount,
      'paid_to': paidTo,
      'received_from': receivedFrom,
      'transaction_date': transactionDate.toIso8601String(),
      'transaction_time': transactionTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      category: entity.category,
      transactionType: entity.transactionType,
      transactionAmount: entity.transactionAmount,
      paidTo: entity.paidTo,
      receivedFrom: entity.receivedFrom,
      transactionDate: entity.transactionDate,
      transactionTime: entity.transactionTime,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
