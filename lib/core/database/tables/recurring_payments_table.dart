import 'package:drift/drift.dart';

class RecurringPaymentsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 100)();

  RealColumn get amount => real()();

  IntColumn get type => integer()();

  IntColumn get accountId => integer().nullable().customConstraint(
    'REFERENCES accounts_table(id) ON DELETE SET NULL',
  )();

  IntColumn get categoryId => integer().nullable().customConstraint(
    'REFERENCES categories_table(id) ON DELETE SET NULL',
  )();

  IntColumn get frequency => integer()();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime().nullable()();

  IntColumn get customDays => integer().nullable()();
}
