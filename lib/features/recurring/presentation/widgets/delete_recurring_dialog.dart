import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/widgets/ff_button.dart';
import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';
import 'package:finflow_app/features/recurring/presentation/providers/recurring_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteRecurringDialog extends ConsumerWidget {
  final RecurringPayment payment;

  const DeleteRecurringDialog({required this.payment, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.ffColors;

    return AlertDialog(
      title: Text(
        'Elimina ricorrente',
        style: FFTypography.headingMd.copyWith(color: colors.textPrimary),
      ),
      content: Text(
        "Vuoi eliminare '${payment.name}'?",
        style: FFTypography.bodyMd.copyWith(color: colors.textPrimary),
      ),
      actions: [
        FFButton(
          label: "Elimina",
          variant: FFButtonVariant.destructive,
          onPressed: () {
            ref.read(recurringRepositoryProvider).delete(payment.id);
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
