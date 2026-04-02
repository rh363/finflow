import 'package:drift/drift.dart';

class TransactionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get amount => real()();

  IntColumn get type => integer()();

  IntColumn get categoryId => integer().nullable().customConstraint(
    'REFERENCES categories_table(id) ON DELETE SET NULL',
  )();

  IntColumn get accountId => integer().nullable().customConstraint(
    'REFERENCES accounts_table(id) ON DELETE SET NULL',
  )();

  DateTimeColumn get date => dateTime()();

  TextColumn get notes => text().nullable()();
}
