import 'package:finflow_app/features/transactions/domain/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_list_item.freezed.dart';

/// Una transazione "pronta da disegnare": i campi corrispondono 1:1 ai
/// parametri di TransactionListTile. I join (categoria, conto) sono già
/// risolti — è un view model di presentation, NON un'entità di dominio.
@freezed
abstract class TransactionListItem with _$TransactionListItem {
  const factory TransactionListItem({
    required String id,
    required String categoryIcon,
    required String categoryName,
    required DateTime date,
    required double amount,
    required String currency,
    required TransactionType type,
    String? note,
  }) = _TransactionListItem;
}
