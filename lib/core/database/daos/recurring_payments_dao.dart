import 'package:drift/drift.dart';
import 'package:finflow_app/core/database/app_database.dart';
import 'package:finflow_app/core/database/tables/recurring_payments_table.dart';

part 'recurring_payments_dao.g.dart';

@DriftAccessor(tables: [RecurringPaymentsTable])
class RecurringPaymentsDao extends DatabaseAccessor<AppDatabase>
    with _$RecurringPaymentsDaoMixin {
  RecurringPaymentsDao(super.db);

  Future<List<RecurringPaymentsTableData>> getAllRecurringPayments() =>
      select(recurringPaymentsTable).get();

  Stream<List<RecurringPaymentsTableData>> watchAllRecurringPayments() =>
      select(recurringPaymentsTable).watch();

  Future<List<RecurringPaymentsTableData>> getAllActiveRecurringPayments() =>
      (select(recurringPaymentsTable)..where(
            (rp) =>
                rp.endDate.isNull() |
                rp.endDate.isBiggerOrEqualValue(DateTime.now()),
          ))
          .get();

  Future<int> insertRecurringPayment(
    RecurringPaymentsTableCompanion recurringPayment,
  ) => into(recurringPaymentsTable).insert(recurringPayment);

  Future<bool> updateRecurringPayment(
    RecurringPaymentsTableCompanion recurringPayment,
  ) => update(recurringPaymentsTable).replace(recurringPayment);

  Future<int> deleteRecurringPayment(int id) =>
      (delete(recurringPaymentsTable)..where((rp) => rp.id.equals(id))).go();
}
