import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_shadows.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:flutter/material.dart';

enum FFButtonVariant { primary, secondary }

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

  bool get _isPrimary => variant == FFButtonVariant.primary;

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;

    return Opacity(
      opacity: onPressed == null ? 0.4 : 1.0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: FFRadius.sm,
        child: Ink(
          decoration: BoxDecoration(
            color: _isPrimary ? colors.accentDefault : Colors.transparent,
            borderRadius: FFRadius.sm,
            border: _isPrimary ? null : Border.all(color: colors.borderDefault),
            boxShadow: _isPrimary ? FFShadows.accent : null,
          ),
          padding: _isPrimary
              ? const EdgeInsets.symmetric(
                  vertical: FFSpacing.lg,
                  horizontal: FFSpacing.xxl,
                )
              : const EdgeInsets.symmetric(
                  vertical: FFSpacing.md,
                  horizontal: FFSpacing.xl,
                ),
          child: Center(
            child: Text(
              label,
              style: FFTypography.headingSm.copyWith(
                color: _isPrimary ? colors.textOnAccent : colors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
