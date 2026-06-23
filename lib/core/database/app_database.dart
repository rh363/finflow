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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.alterTable(.new(transactionsTable));
        await migrator.alterTable(.new(recurringPaymentsTable));
      }
      if (from < 3) {
        // Bonifica i riferimenti FK rimasti orfani mentre le foreign key
        // erano disattivate (es. categoria eliminata senza che il SET NULL
        // scattasse). Li azzera così l'app non vede più id penzolanti.
        await customStatement(
          'UPDATE transactions_table SET category_id = NULL '
          'WHERE category_id NOT IN (SELECT id FROM categories_table)',
        );
        await customStatement(
          'UPDATE transactions_table SET account_id = NULL '
          'WHERE account_id NOT IN (SELECT id FROM accounts_table)',
        );
        await customStatement(
          'UPDATE recurring_payments_table SET category_id = NULL '
          'WHERE category_id NOT IN (SELECT id FROM categories_table)',
        );
        await customStatement(
          'UPDATE recurring_payments_table SET account_id = NULL '
          'WHERE account_id NOT IN (SELECT id FROM accounts_table)',
        );
      }
    },
    // Le foreign key in SQLite sono OFF per connessione: senza questo,
    // il `ON DELETE SET NULL` delle tabelle non scatta mai.
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
