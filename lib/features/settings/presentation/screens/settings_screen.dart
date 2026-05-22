import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/features/settings/presentation/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Impostazioni",
          style: FFTypography.displaySm.copyWith(color: colors.textPrimary),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: FFSpacing.lg,
          vertical: FFSpacing.md,
        ),
        children: [
          SettingsTile(
            icon: LucideIcons.tag,
            label: "Categorie",
            onTap: () {
              context.push('/settings/categories');
            },
          ),
          SettingsTile(
            icon: LucideIcons.wallet,
            label: "Conti",
            onTap: () {
              context.push('/settings/accounts');
            },
          ),
        ],
      ),
    );
  }
}
