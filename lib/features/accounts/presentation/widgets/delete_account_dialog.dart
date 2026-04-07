import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/widgets/ff_button.dart';
import 'package:finflow_app/features/accounts/domain/account.dart';
import 'package:finflow_app/features/accounts/presentation/providers/accounts_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteAccountDialog extends ConsumerWidget {
  final Account account;

  const DeleteAccountDialog({required this.account, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.ffColors;
    return AlertDialog(
      title: Text(
        'Elimina conto',
        style: FFTypography.headingMd.copyWith(color: colors.textPrimary),
      ),
      content: Text(
        "Vuoi eliminare '${account.name}'?",
        style: FFTypography.bodyMd.copyWith(color: colors.textPrimary),
      ),
      actions: [
        FFButton(
          label: "Elimina",
          variant: FFButtonVariant.destructive,
          onPressed: () {
            final repo = ref.read(accountsRepositoryProvider);
            repo.delete(account.id);
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: FFSpacing.sm),
        FFButton(
          label: "Annulla",
          variant: FFButtonVariant.tertiary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
