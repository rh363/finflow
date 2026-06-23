import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';
import 'package:finflow_app/features/recurring/presentation/providers/recurring_providers.dart';
import 'package:finflow_app/features/recurring/presentation/widgets/delete_recurring_dialog.dart';
import 'package:finflow_app/features/recurring/presentation/widgets/recurring_form_sheet.dart';
import 'package:finflow_app/features/recurring/presentation/widgets/recurring_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecurringScreen extends ConsumerWidget {
  const RecurringScreen({super.key});

  void _openForm(BuildContext context, {RecurringPayment? payment}) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) => RecurringFormSheet(payment: payment),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.ffColors;
    final async = ref.watch(recurringProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ricorrenti",
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
        child: async.when(
          data: (items) => items.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: FFSpacing.lg),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    color: colors.borderDefault,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return RecurringListTile(
                      payment: item,
                      onTap: () => _openForm(context, payment: item),
                      onLongPress: () => showDialog(
                        context: context,
                        builder: (context) =>
                            DeleteRecurringDialog(payment: item),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Nessun pagamento ricorrente.",
                        style: FFTypography.headingMd.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: FFSpacing.xs),
                      Text(
                        "Clicca sul '+' per aggiungerne uno.",
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
                  "Impossibile caricare i ricorrenti.",
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
