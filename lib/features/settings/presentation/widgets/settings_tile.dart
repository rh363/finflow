import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: FFRadius.xs,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: FFSpacing.md,
            horizontal: FFSpacing.xs,
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: colors.textSecondary),
              const SizedBox(width: FFSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: FFTypography.bodyMd.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ),
              Icon(LucideIcons.chevronRight, size: 18, color: colors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
