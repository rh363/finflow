import 'package:drift/drift.dart';

class AccountsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 100)();

  TextColumn get currency => text().withLength(min: 1, max: 3)();

  TextColumn get icon => text()();

  RealColumn get balance => real()();

  IntColumn get type => integer()();
}
