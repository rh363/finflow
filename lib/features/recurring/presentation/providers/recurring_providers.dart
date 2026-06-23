import 'package:finflow_app/core/providers/app_providers.dart';
import 'package:finflow_app/features/recurring/data/recurring_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recurringRepositoryProvider = Provider<RecurringRepository>((ref) {
  final dao = ref.watch(recurringPaymentsDaoProvider);
  return RecurringRepository(dao);
});

final recurringProvider = StreamProvider((ref) {
  final repo = ref.watch(recurringRepositoryProvider);
  return repo.watchAll();
});
