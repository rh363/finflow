import 'package:finflow_app/core/providers/app_providers.dart';
import 'package:finflow_app/features/accounts/data/accounts_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountsRepositoryProvider = Provider<AccountsRepository>((ref) {
  final dao = ref.watch(accountsDaoProvider);
  return AccountsRepository(dao);
});

final accountsProvider = StreamProvider((ref) {
  final repo = ref.watch(accountsRepositoryProvider);
  return repo.watchAll();
});
