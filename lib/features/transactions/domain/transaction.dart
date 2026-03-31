import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

enum TransactionType { income, expense }

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required double amount,
    required TransactionType type,
    required String categoryId,
    required String accountId,
    required DateTime date,
    String? notes,
  }) = _Transaction;
}
