import 'package:drift/drift.dart';
import 'package:finflow_app/core/database/app_database.dart';
import 'package:finflow_app/core/database/tables/accounts_table.dart';

part 'accounts_dao.g.dart';

@DriftAccessor(tables: [AccountsTable])
class AccountsDao extends DatabaseAccessor<AppDatabase>
    with _$AccountsDaoMixin {
  AccountsDao(super.db);

  Future<List<AccountsTableData>> getAllAccounts() =>
      select(accountsTable).get();

  Stream<List<AccountsTableData>> watchAllAccounts() =>
      select(accountsTable).watch();

  Future<int> insertAccount(AccountsTableCompanion account) =>
      into(accountsTable).insert(account);

  Future<bool> updateAccount(AccountsTableCompanion account) =>
      update(accountsTable).replace(account);

  Future<int> deleteAccount(int id) =>
      (delete(accountsTable)..where((a) => a.id.equals(id))).go();
}
