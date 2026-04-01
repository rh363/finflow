// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_payments_dao.dart';

// ignore_for_file: type=lint
mixin _$RecurringPaymentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecurringPaymentsTableTable get recurringPaymentsTable =>
      attachedDatabase.recurringPaymentsTable;
  RecurringPaymentsDaoManager get managers => RecurringPaymentsDaoManager(this);
}

class RecurringPaymentsDaoManager {
  final _$RecurringPaymentsDaoMixin _db;
  RecurringPaymentsDaoManager(this._db);
  $$RecurringPaymentsTableTableTableManager get recurringPaymentsTable =>
      $$RecurringPaymentsTableTableTableManager(
        _db.attachedDatabase,
        _db.recurringPaymentsTable,
      );
}
