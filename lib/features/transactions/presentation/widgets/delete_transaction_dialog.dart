import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/widgets/ff_button.dart';
import 'package:finflow_app/features/transactions/presentation/models/transaction_list_item.dart';
import 'package:finflow_app/features/transactions/presentation/providers/transactions_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteTransactionDialog extends ConsumerWidget {
  final TransactionListItem item;

  const DeleteTransactionDialog({required this.item, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.ffColors;
    return AlertDialog(
      title: Text(
        'Elimina transazione',
        style: FFTypography.headingMd.copyWith(color: colors.textPrimary),
      ),
      content: Text(
        item.note != null && item.note!.isNotEmpty
            ? "Vuoi eliminare '${item.categoryName} · ${item.note}'?"
            : "Vuoi eliminare questa transazione di '${item.categoryName}'?",
        style: FFTypography.bodyMd.copyWith(color: colors.textPrimary),
      ),
      actions: [
        FFButton(
          label: "Elimina",
          variant: FFButtonVariant.destructive,
          onPressed: () {
            ref.read(transactionsRepositoryProvider).delete(.parse(item.id));
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: FFSpacing.sm),
        FFButton(
          label: "Annulla",
          variant: FFButtonVariant.tertiary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
