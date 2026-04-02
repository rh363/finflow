import 'package:finflow_app/core/database/app_database.dart';
import 'package:finflow_app/core/database/connection.dart';
import 'package:finflow_app/core/database/daos/accounts_dao.dart';
import 'package:finflow_app/core/database/daos/categories_dao.dart';
import 'package:finflow_app/core/database/daos/recurring_payments_dao.dart';
import 'package:finflow_app/core/database/daos/transactions_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Database providers

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(openConnection());
});

// DAO providers

final categoriesDaoProvider = Provider<CategoriesDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.categoriesDao;
});

final accountsDaoProvider = Provider<AccountsDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.accountsDao;
});

final transactionsDaoProvider = Provider<TransactionsDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.transactionsDao;
});

final recurringPaymentsDaoProvider = Provider<RecurringPaymentsDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.recurringPaymentsDao;
});
