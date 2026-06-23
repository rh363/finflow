import 'package:collection/collection.dart';
import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/utils/currency_utils.dart';
import 'package:finflow_app/features/categories/presentation/providers/categories_providers.dart';
import 'package:finflow_app/features/recurring/domain/recurring_engine.dart';
import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';
import 'package:finflow_app/features/transactions/domain/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RecurringListTile extends ConsumerWidget {
  final RecurringPayment payment;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const RecurringListTile({
    required this.payment,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  bool get _isIncome => payment.type == TransactionType.income;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.ffColors;

    // Risolvo la categoria per mostrarne l'emoji (fallback se rimossa/assente).
    final categories = ref.watch(categoriesProvider).value ?? [];
    final category = categories.firstWhereOrNull(
      (c) => c.id == payment.categoryId,
    );
    final categoryIcon = category?.icon ?? '🔁';

    // Prossima data dal motore (puro): vuota se il pagamento è già terminato.
    final next = RecurringEngine.nextOccurrences(
      payment,
      from: DateTime.now(),
      count: 1,
    );
    final nextStr = next.isNotEmpty
        ? DateFormat('dd MMM', 'it_IT').format(next.first)
        : '—';
    final subtitle = '${payment.frequency.label} · prossimo $nextStr';

    final effectiveAmount = _isIncome ? payment.amount : payment.amount * -1;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: FFSpacing.xs,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: FFRadius.xs,
                    color: colors.bgCardAlt,
                  ),
                  child: Center(
                    child: Text(
                      categoryIcon,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(width: FFSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payment.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FFTypography.bodyMd.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FFTypography.caption.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  CurrencyUtils.formatCurrency(effectiveAmount, 'EUR'),
                  style: FFTypography.bodyMd.copyWith(
                    color: _isIncome
                        ? colors.semanticPositive
                        : colors.semanticNegative,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
