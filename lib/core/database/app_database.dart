import 'package:drift/drift.dart';
import 'package:finflow_app/core/database/daos/accounts_dao.dart';
import 'package:finflow_app/core/database/daos/categories_dao.dart';
import 'package:finflow_app/core/database/daos/recurring_payments_dao.dart';
import 'package:finflow_app/core/database/daos/transactions_dao.dart';
import 'package:finflow_app/core/database/tables/accounts_table.dart';
import 'package:finflow_app/core/database/tables/categories_table.dart';
import 'package:finflow_app/core/database/tables/recurring_payments_table.dart';
import 'package:finflow_app/core/database/tables/transactions_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CategoriesTable,
    AccountsTable,
    TransactionsTable,
    RecurringPaymentsTable,
  ],
  daos: [CategoriesDao, AccountsDao, TransactionsDao, RecurringPaymentsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
