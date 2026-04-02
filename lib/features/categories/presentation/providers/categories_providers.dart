import 'package:finflow_app/core/providers/app_providers.dart';
import 'package:finflow_app/features/categories/data/categories_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  final dao = ref.watch(categoriesDaoProvider);
  return CategoriesRepository(dao);
});

final categoriesProvider = StreamProvider((ref) {
  final repo = ref.watch(categoriesRepositoryProvider);
  return repo.watchAll();
});
