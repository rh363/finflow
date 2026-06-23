import 'package:drift/drift.dart';
import 'package:finflow_app/core/database/app_database.dart';
import 'package:finflow_app/core/database/daos/recurring_payments_dao.dart';
import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';
import 'package:finflow_app/features/transactions/domain/transaction.dart';

class RecurringRepository {
  final RecurringPaymentsDao _dao;

  RecurringRepository(this._dao);

  Stream<List<RecurringPayment>> watchAll() => _dao
      .watchAllRecurringPayments()
      .map((rows) => rows.map(_toEntity).toList());

  Future<void> add({
    required String name,
    required double amount,
    required TransactionType type,
    required RecurrenceFrequency frequency,
    required DateTime startDate,
    String? categoryId,
    String? accountId,
    DateTime? endDate,
    int? customDays,
  }) => _dao.insertRecurringPayment(
    RecurringPaymentsTableCompanion.insert(
      name: name,
      amount: amount,
      type: type.index,
      frequency: frequency.index,
      startDate: startDate,
      categoryId: Value(_toInt(categoryId)),
      accountId: Value(_toInt(accountId)),
      endDate: Value(endDate),
      customDays: Value(customDays),
    ),
  );

  Future<bool> update({
    required String id,
    required String name,
    required double amount,
    required TransactionType type,
    required RecurrenceFrequency frequency,
    required DateTime startDate,
    String? categoryId,
    String? accountId,
    DateTime? endDate,
    int? customDays,
  }) => _dao.updateRecurringPayment(
    RecurringPaymentsTableCompanion(
      id: Value(.parse(id)),
      name: Value(name),
      amount: Value(amount),
      type: Value(type.index),
      frequency: Value(frequency.index),
      startDate: Value(startDate),
      categoryId: Value(_toInt(categoryId)),
      accountId: Value(_toInt(accountId)),
      endDate: Value(endDate),
      customDays: Value(customDays),
    ),
  );

  Future<void> delete(String id) => _dao.deleteRecurringPayment(.parse(id));

  static RecurringPayment _toEntity(RecurringPaymentsTableData row) =>
      RecurringPayment(
        id: row.id.toString(),
        name: row.name,
        amount: row.amount,
        type: TransactionType.values[row.type],
        categoryId: row.categoryId?.toString(),
        accountId: row.accountId?.toString(),
        frequency: RecurrenceFrequency.values[row.frequency],
        startDate: row.startDate,
        customDays: row.customDays,
        endDate: row.endDate,
      );

  static int? _toInt(String? id) => id == null ? null : .tryParse(id);
}
