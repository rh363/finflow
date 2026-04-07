import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/features/accounts/presentation/providers/accounts_providers.dart';
import 'package:finflow_app/features/accounts/presentation/widgets/account_form_sheet.dart';
import 'package:finflow_app/features/accounts/presentation/widgets/account_list_tile.dart';
import 'package:finflow_app/features/accounts/presentation/widgets/delete_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.ffColors;
    final futureAccounts = ref.watch(accountsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Conti",
          style: FFTypography.displaySm.copyWith(color: colors.textPrimary),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AccountFormSheet(),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: FFSpacing.xxl),
        child: futureAccounts.when(
          data: (accounts) => accounts.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, idx) {
                    final a = accounts[idx];
                    return AccountListTile(
                      icon: a.icon,
                      name: a.name,
                      type: a.type,
                      balance: a.balance,
                      currency: a.currency,
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => AccountFormSheet(account: a),
                      ),
                      onLongPress: () => showDialog(
                        context: context,
                        builder: (context) => DeleteAccountDialog(account: a),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: FFSpacing.sm,
                    ),
                    child: Divider(height: 1, color: colors.borderDefault),
                  ),
                  itemCount: accounts.length,
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Nessun conto presente.",
                        style: FFTypography.headingMd.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        "Clicca sul '+' per aggiungerne uno.",
                        style: FFTypography.caption.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
          error: (err, stack) {
            print(err);
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Impossibile caricare i conti.",
                    style: FFTypography.headingMd.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  Text(
                    "Errore: ${err.toString()}",
                    style: FFTypography.caption.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
