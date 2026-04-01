import 'package:drift/drift.dart';

class CategoriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 100)();

  TextColumn get icon => text()();

  IntColumn get color => integer()();

  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}
