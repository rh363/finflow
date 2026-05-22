import 'package:collection/collection.dart';
import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/features/transactions/domain/transaction.dart';
import 'package:finflow_app/features/transactions/presentation/providers/transactions_providers.dart';
import 'package:finflow_app/features/transactions/presentation/widgets/delete_transaction_dialog.dart';
import 'package:finflow_app/features/transactions/presentation/widgets/transaction_form_sheet.dart';
import 'package:finflow_app/features/transactions/presentation/widgets/transaction_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  void _openForm(BuildContext context, {Transaction? transaction}) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) => TransactionFormSheet(transaction: transaction),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.ffColors;
    final asyncTransactions = ref.watch(transactionListItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transazioni",
          style: FFTypography.displaySm.copyWith(color: colors.textPrimary),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.accentDefault,
        child: Icon(Icons.add, color: colors.textOnAccent),
        onPressed: () => _openForm(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: FFSpacing.xxl),
        child: asyncTransactions.when(
          data: (items) => items.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: FFSpacing.lg),
                  itemCount: items.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                      thickness: 1,
                      color: colors.borderDefault,
                    );
                  },
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return TransactionListTile(
                      categoryIcon: item.categoryIcon,
                      categoryName: item.categoryName,
                      date: item.date,
                      amount: item.amount,
                      currency: item.currency,
                      type: item.type,
                      note: item.note,
                      onTap: () {
                        final transactions =
                            ref.read(transactionsProvider).value ?? [];
                        final tx = transactions.firstWhereOrNull(
                          (t) => t.id == item.id,
                        );
                        if (tx == null) return;
                        _openForm(context, transaction: tx);
                      },
                      onLongPress: () => showDialog(
                        context: context,
                        builder: (context) =>
                            DeleteTransactionDialog(item: item),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Nessuna transazione.",
                        style: FFTypography.headingMd.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: FFSpacing.xs),
                      Text(
                        "Clicca sul '+' per aggiungerne una.",
                        style: FFTypography.caption.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
          error: (err, stack) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Impossibile caricare le transazioni.",
                  style: FFTypography.headingMd.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: FFSpacing.xs),
                Text(
                  "Errore: $err",
                  style: FFTypography.caption.copyWith(color: colors.textMuted),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
