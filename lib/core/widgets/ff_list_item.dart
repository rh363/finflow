import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:flutter/material.dart';

class FFListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final bool isPositive;
  final IconData? icon;

  const FFListItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isPositive,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: FFRadius.xs,
                  color: colors.bgCardAlt,
                ),
                child: Center(child: Icon(icon, size: 18)),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FFTypography.bodyMd.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: FFTypography.caption.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: FFTypography.bodyMd.copyWith(
                fontWeight: FontWeight.w600,
                color: isPositive
                    ? colors.semanticPositive
                    : colors.semanticNegative,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
