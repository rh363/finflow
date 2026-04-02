import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CategoryChip({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? colors.accentBg : colors.bgCardAlt,
          border: Border.all(
            width: isSelected ? 2 : 0,
            color: isSelected ? colors.accentDefault : Colors.transparent,
          ),
          borderRadius: FFRadius.sm,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: FFSpacing.md,
            horizontal: FFSpacing.xs,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 4),
              Text(
                label,
                style: FFTypography.captionXs.copyWith(
                  color: isSelected
                      ? colors.accentDefault
                      : colors.textSecondary,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // ← tronca il testo lungo
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
