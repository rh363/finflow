import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/features/recurring/domain/recurring_engine.dart';
import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Mostra le prossime [count] date di un pagamento ricorrente.
///
/// È il punto in cui il RecurringEngine entra in scena nella UI. 🎯
class NextPaymentsPreview extends StatelessWidget {
  final RecurringPayment payment;
  final int count;

  const NextPaymentsPreview({
    required this.payment,
    this.count = 3,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;

    // Il motore puro che hai scritto e testato: nessuna dipendenza dal DB.
    final dates = RecurringEngine.nextOccurrences(
      payment,
      from: DateTime.now(),
      count: count,
    );

    if (dates.isEmpty) return const SizedBox.shrink();

    final formatter = DateFormat('dd MMM yyyy', 'it_IT');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Prossimi pagamenti",
          style: FFTypography.caption.copyWith(color: colors.textMuted),
        ),
        const SizedBox(height: FFSpacing.xs),
        Wrap(
          spacing: FFSpacing.sm,
          runSpacing: FFSpacing.xs,
          children: [
            for (final d in dates)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: FFSpacing.sm,
                  vertical: FFSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: colors.bgCardAlt,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  formatter.format(d),
                  style: FFTypography.caption.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
