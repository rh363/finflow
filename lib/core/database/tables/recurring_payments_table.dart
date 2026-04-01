import 'package:drift/drift.dart';

class RecurringPaymentsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 100)();

  RealColumn get amount => real()();

  IntColumn get type => integer()();

  IntColumn get accountId => integer()();

  IntColumn get categoryId => integer()();

  IntColumn get frequency => integer()();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime().nullable()();

  IntColumn get customDays => integer().nullable()();
}
