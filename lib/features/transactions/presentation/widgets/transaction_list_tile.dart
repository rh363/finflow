import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/utils/currency_utils.dart';
import 'package:finflow_app/features/transactions/domain/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListTile extends StatelessWidget {
  final String categoryIcon;
  final String categoryName;
  final DateTime date;
  final double amount;
  final String currency;
  final TransactionType type;
  final String? note;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const TransactionListTile({
    required this.categoryIcon,
    required this.categoryName,
    required this.date,
    required this.amount,
    required this.currency,
    required this.type,
    this.note,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  bool get _isIncome => type == TransactionType.income;

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;
    final dateStr = DateFormat('dd MMM', 'it_IT').format(date);
    final subtitle = (note != null && note!.isNotEmpty)
        ? '$dateStr · $note'
        : dateStr;
    final effectiveAmount = _isIncome ? amount : amount * -1;

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
                // --- icon container (36x36, radius.xs, bg cardAlt) ---
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

                // --- title + subtitle ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoryName,
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
                  CurrencyUtils.formatCurrency(effectiveAmount, currency),
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
