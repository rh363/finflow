import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:flutter/material.dart';

class FFCard extends StatelessWidget {
  final Widget child;
  final List<BoxShadow>? shadow;

  const FFCard({required this.child, this.shadow, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.bgCard,
        border: Border.all(color: colors.borderDefault),
        borderRadius: FFRadius.md,
        boxShadow: shadow,
      ),
      padding: const EdgeInsets.all(FFSpacing.xl),
      child: child,
    );
  }
}
