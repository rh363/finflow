import 'package:finflow_app/core/providers/app_providers.dart';
import 'package:finflow_app/features/accounts/presentation/providers/accounts_providers.dart';
import 'package:finflow_app/features/categories/presentation/providers/categories_providers.dart';
import 'package:finflow_app/features/transactions/data/transactions_repository.dart';
import 'package:finflow_app/features/transactions/presentation/models/transaction_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  final dao = ref.watch(transactionsDaoProvider);
  return TransactionsRepository(dao);
});

final transactionsProvider = StreamProvider((ref) {
  final repo = ref.watch(transactionsRepositoryProvider);
  return repo.watchAll();
});

/// Combina transazioni + categorie + conti e produce la lista già risolta.
/// Lo screen guarda SOLO questo provider e fa UN solo .when().
final transactionListItemsProvider =
    Provider<AsyncValue<List<TransactionListItem>>>((ref) {
      final txs = ref.watch(transactionsProvider);
      final cats = ref.watch(categoriesProvider);
      final accs = ref.watch(accountsProvider);

      return txs.whenData((transactions) {
        final catList = cats.value ?? [];
        final accList = accs.value ?? [];

        final catById = {for (final c in catList) c.id: c};
        final accById = {for (final a in accList) a.id: a};

        // 2. mappa ogni transazione in un TransactionListItem,
        //    risolvendo categoria e conto con fallback sui nullable:
        //      - categoria mancante -> icon "❓", name "Senza categoria"
        //      - conto mancante     -> currency "EUR"
        // return transactions.map((t) { ... }).toList();

        final transactionList = <TransactionListItem>[];

        for (final t in transactions) {
          final cat = catById[t.categoryId];
          final acc = accById[t.accountId];

          transactionList.add(
            TransactionListItem(
              id: t.id,
              categoryIcon: cat?.icon ?? '?',
              categoryName: cat?.name ?? 'Senza categoria',
              date: t.date,
              amount: t.amount,
              currency: acc?.currency ?? 'EUR',
              type: t.type,
              note: t.notes,
            ),
          );
        }

        return transactionList;
      });
    });
