import 'package:drift/drift.dart';

class TransactionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get amount => real()();

  IntColumn get type => integer()();

  IntColumn get categoryId => integer()();

  IntColumn get accountId => integer()();

  DateTimeColumn get date => dateTime()();

  TextColumn get notes => text().nullable()();
}
