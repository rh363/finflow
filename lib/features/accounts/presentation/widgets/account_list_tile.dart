import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/utils/currency_utils.dart';
import 'package:finflow_app/features/accounts/domain/account.dart';
import 'package:flutter/material.dart';

class AccountListTile extends StatelessWidget {
  final String icon;
  final String name;
  final AccountType type;
  final double balance;
  final String currency;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AccountListTile({
    super.key,
    required this.icon,
    required this.name,
    required this.type,
    required this.balance,
    required this.currency,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        // splashColor: colors.bgCardAlt,
        // highlightColor: colors.bgCardAlt,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: FFSpacing.md),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FFSpacing.md,
                horizontal: FFSpacing.xs,
              ),
              child: Row(
                children: [
                  //icon
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: FFRadius.xs,
                      color: colors.bgCardAlt,
                    ),
                    child: Center(
                      child: Text(icon, style: const TextStyle(fontSize: 22)),
                    ),
                  ),
                  //text
                  const SizedBox(width: FFSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: FFTypography.bodyMd.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          type.label,
                          style: FFTypography.caption.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //amount
                  Text(
                    CurrencyUtils.formatCurrency(balance, currency),
                    style: FFTypography.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                      color: balance >= 0
                          ? colors.textPrimary
                          : colors.semanticNegative,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
