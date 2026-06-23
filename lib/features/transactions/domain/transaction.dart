import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

enum TransactionType { income, expense }

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required double amount,
    required TransactionType type,
    String? categoryId,
    String? accountId,
    required DateTime date,
    String? notes,
  }) = _Transaction;
}

extension TransactionTypeLabel on TransactionType {
  String get label => switch (this) {
    TransactionType.income => "Entrate",
    TransactionType.expense => "Uscite",
  };
}
