import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_shadows.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:flutter/material.dart';

enum FFButtonVariant { primary, secondary, tertiary, destructive }

class FFButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final FFButtonVariant variant;

  const FFButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = FFButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;
    final bgColor = switch (variant) {
      FFButtonVariant.primary => colors.accentDefault,
      FFButtonVariant.destructive => colors.semanticNegative,
      _ => Colors.transparent,
    };
    final border = switch (variant) {
      FFButtonVariant.secondary => Border.all(color: colors.borderDefault),
      _ => null,
    };
    final boxShadow = switch (variant) {
      FFButtonVariant.primary => FFShadows.accent,
      _ => null,
    };
    final padding = switch (variant) {
      FFButtonVariant.primary ||
      FFButtonVariant.destructive => const EdgeInsets.symmetric(
        vertical: FFSpacing.lg,
        horizontal: FFSpacing.xxl,
      ),
      _ => const EdgeInsets.symmetric(
        vertical: FFSpacing.md,
        horizontal: FFSpacing.xl,
      ),
    };
    final textColor = switch (variant) {
      FFButtonVariant.primary => colors.textOnAccent,
      FFButtonVariant.destructive => colors.textOnAccent,
      FFButtonVariant.secondary => colors.textPrimary,
      FFButtonVariant.tertiary => colors.accentDefault,
    };
    return Opacity(
      opacity: onPressed == null ? 0.4 : 1.0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: FFRadius.sm,
        child: Ink(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: FFRadius.sm,
            border: border,
            boxShadow: boxShadow,
          ),
          padding: padding,
          child: Center(
            child: Text(
              label,
              style: FFTypography.headingSm.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
