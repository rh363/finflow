import 'package:drift/drift.dart';
import 'package:finflow_app/core/database/app_database.dart';
import 'package:finflow_app/core/database/daos/accounts_dao.dart';
import 'package:finflow_app/features/accounts/domain/account.dart';

class AccountsRepository {
  final AccountsDao _dao;

  AccountsRepository(this._dao);

  Stream<List<Account>> watchAll() {
    return _dao.watchAllAccounts().map((rows) => rows.map(_toEntity).toList());
  }

  Future<void> add({
    required String name,
    required String currency,
    required String icon,
    required double balance,
    required AccountType type,
  }) {
    return _dao.insertAccount(
      AccountsTableCompanion.insert(
        name: name,
        currency: currency,
        icon: icon,
        balance: balance,
        type: type.index,
      ),
    );
  }

  Future<void> update({
    required int id,
    required String name,
    required String currency,
    required String icon,
    required double balance,
    required AccountType type,
  }) {
    return _dao.updateAccount(
      AccountsTableCompanion(
        id: Value(id),
        name: Value(name),
        currency: Value(currency),
        icon: Value(icon),
        balance: Value(balance),
        type: Value(type.index),
      ),
    );
  }

  Future<void> delete(String id) {
    return _dao.deleteAccount(.parse(id));
  }

  static Account _toEntity(AccountsTableData row) => Account(
    id: row.id.toString(),
    name: row.name,
    type: AccountType.values[row.type],
    balance: row.balance,
    currency: row.currency,
    icon: row.icon,
  );
}
