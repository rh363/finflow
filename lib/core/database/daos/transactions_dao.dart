import 'package:drift/drift.dart';
import 'package:finflow_app/core/database/app_database.dart';
import 'package:finflow_app/core/database/tables/transactions_table.dart';

part 'transactions_dao.g.dart';

@DriftAccessor(tables: [TransactionsTable])
class TransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionsDaoMixin {
  TransactionsDao(super.db);

  Future<List<TransactionsTableData>> getAllTransactions() => (select(
    transactionsTable,
  )..orderBy([(t) => OrderingTerm.desc(t.date)])).get();

  Stream<List<TransactionsTableData>> watchAllTransactions() => (select(
    transactionsTable,
  )..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  Future<List<TransactionsTableData>> getTransactionsByAccount(int accountId) =>
      (select(transactionsTable)
            ..where((t) => t.accountId.equals(accountId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  Stream<List<TransactionsTableData>> watchTransactionsByAccount(
    int accountId,
  ) =>
      (select(transactionsTable)
            ..where((t) => t.accountId.equals(accountId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Future<List<TransactionsTableData>> getTransactionByDateRange(
    DateTime from,
    DateTime to,
  ) =>
      (select(transactionsTable)
            ..where((t) => t.date.isBetweenValues(from, to))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  Stream<List<TransactionsTableData>> watchTransactionByDateRange(
    DateTime from,
    DateTime to,
  ) =>
      (select(transactionsTable)
            ..where((t) => t.date.isBetweenValues(from, to))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Future<int> insertTransaction(TransactionsTableCompanion transaction) =>
      into(transactionsTable).insert(transaction);

  Future<bool> updateTransaction(TransactionsTableCompanion transaction) =>
      update(transactionsTable).replace(transaction);

  Future<int> deleteTransaction(int id) =>
      (delete(transactionsTable)..where((t) => t.id.equals(id))).go();
}
