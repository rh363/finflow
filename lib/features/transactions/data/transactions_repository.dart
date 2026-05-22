import 'package:drift/drift.dart';
import 'package:finflow_app/core/database/app_database.dart';
import 'package:finflow_app/core/database/daos/transactions_dao.dart';
import 'package:finflow_app/features/transactions/domain/transaction.dart';

class TransactionsRepository {
  final TransactionsDao _dao;

  TransactionsRepository(this._dao);

  Stream<List<Transaction>> watchAll() =>
      _dao.watchAllTransactions().map((rows) => rows.map(_toEntity).toList());

  Future<void> add({
    required double amount,
    required TransactionType type,
    required DateTime date,
    String? notes,
    int? categoryId,
    int? accountId,
  }) => _dao.insertTransaction(
    TransactionsTableCompanion.insert(
      amount: amount,
      type: type.index,
      date: date,
      notes: Value(notes),
      categoryId: Value(categoryId),
      accountId: Value(accountId),
    ),
  );

  Future<void> update({
    required int id,
    required double amount,
    required TransactionType type,
    required DateTime date,
    String? notes,
    int? categoryId,
    int? accountId,
  }) => _dao.updateTransaction(
    TransactionsTableCompanion(
      id: Value(id),
      amount: Value(amount),
      type: Value(type.index),
      date: Value(date),
      notes: Value(notes),
      categoryId: Value(categoryId),
      accountId: Value(accountId),
    ),
  );

  Future<void> delete(int id) => _dao.deleteTransaction(id);

  static Transaction _toEntity(TransactionsTableData row) => Transaction(
    id: row.id.toString(),
    amount: row.amount,
    date: row.date,
    notes: row.notes,
    type: TransactionType.values[row.type],
    categoryId: row.categoryId.toString(),
    accountId: row.accountId.toString(),
  );
}
