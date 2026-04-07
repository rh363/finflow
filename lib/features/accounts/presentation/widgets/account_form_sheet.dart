import 'package:finflow_app/core/constants/currency_constants.dart';
import 'package:finflow_app/core/constants/emoji_constants.dart';
import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/widgets/ff_button.dart';
import 'package:finflow_app/core/widgets/ff_input.dart';
import 'package:finflow_app/features/accounts/domain/account.dart';
import 'package:finflow_app/features/accounts/presentation/providers/accounts_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountFormSheet extends ConsumerStatefulWidget {
  final Account? account;

  AccountFormSheet({this.account, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AccountFormSheetState();
}

class _AccountFormSheetState extends ConsumerState<AccountFormSheet> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  AccountType _selectedType = AccountType.checking;
  String _selectedIcon = EmojiConstants.accountEmojis[0];
  String _selectedCurrency = CurrencyConstants.currencies.keys.first;

  bool _isNameValid = false;
  bool _isBalanceValid = false;

  bool get _isFormValid => _isNameValid && _isBalanceValid;

  bool get _isInEditMode => widget.account != null;

  bool _isSelectedIcon(String icon) => _selectedIcon == icon;

  static const _emojis = EmojiConstants.accountEmojis;

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final acc = widget.account;
    if (acc != null) {
      _nameController.text = acc.name;
      _balanceController.text = acc.balance.toString();
      _selectedType = acc.type;
      _selectedIcon = acc.icon;
      _selectedCurrency = acc.currency;
      _isNameValid = true;
      _isBalanceValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        FFSpacing.lg,
        FFSpacing.sm,
        FFSpacing.lg,
        FFSpacing.xl,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.borderDefault,
                  borderRadius: FFRadius.full,
                ),
              ),
            ),
            const SizedBox(height: FFSpacing.lg),
            Text(
              _isInEditMode ? "Modifica conto" : "Nuovo conto",
              style: FFTypography.headingMd.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: FFSpacing.lg),
            FFInput(
              label: "Nome",
              hint: "Inserisci il nome della categoria",
              controller: _nameController,
              onChanged: (value) {
                if (_isNameValid != value.isNotEmpty) {
                  setState(() {
                    _isNameValid = !_isNameValid;
                  });
                }
              },
            ),
            const SizedBox(height: FFSpacing.lg),
            FFInput(
              label: "Saldo iniziale",
              hint: "0.00",
              controller: _balanceController,
              textInputType: TextInputType.number,
              onChanged: (value) {
                final valid =
                    value.isNotEmpty &&
                    double.tryParse(value.replaceAll(',', '.')) != null;
                if (_isBalanceValid != valid) {
                  setState(() => _isBalanceValid = valid);
                }
              },
            ),
            const SizedBox(height: FFSpacing.lg),
            Text(
              "Icona",
              style: FFTypography.caption.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: FFSpacing.sm),
            Wrap(
              spacing: FFSpacing.sm,
              runSpacing: FFSpacing.sm,
              children: [
                for (final emoji in _emojis)
                  GestureDetector(
                    onTap: () => setState(() {
                      _selectedIcon = emoji;
                    }),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _isSelectedIcon(emoji)
                            ? colors.accentBg
                            : colors.bgCardAlt,
                        border: Border.all(
                          color: _isSelectedIcon(emoji)
                              ? colors.accentDefault
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: FFRadius.sm,
                      ),
                      child: Text(emoji, style: const TextStyle(fontSize: 22)),
                    ),
                  ),
              ],
            ),
            DropdownButtonFormField<AccountType>(
              initialValue: _selectedType,
              decoration: InputDecoration(
                labelText: 'Tipo',
                labelStyle: FFTypography.caption.copyWith(
                  color: colors.textMuted,
                ),
              ),
              items: [
                for (final type in AccountType.values)
                  DropdownMenuItem(value: type, child: Text(type.label)),
              ],
              onChanged: (value) => setState(() => _selectedType = value!),
            ),
            DropdownButtonFormField<String>(
              initialValue: _selectedCurrency,
              decoration: InputDecoration(
                labelText: 'Valuta',
                labelStyle: FFTypography.caption.copyWith(
                  color: colors.textMuted,
                ),
              ),
              items: [
                for (final entry in CurrencyConstants.currencies.entries)
                  DropdownMenuItem(
                    value: entry.key,
                    child: Text("${entry.value} ${entry.key}"),
                  ),
              ],
              onChanged: (value) => setState(() {
                _selectedCurrency = value!;
              }),
            ),
            const SizedBox(height: FFSpacing.xl),
            SizedBox(
              width: double.infinity,
              child: FFButton(
                label: "Salva",
                variant: FFButtonVariant.primary,
                onPressed: _isFormValid
                    ? () {
                        final repo = ref.read(accountsRepositoryProvider);
                        if (_isInEditMode) {
                          final a = widget.account!;
                          repo.update(
                            id: .parse(a.id),
                            name: _nameController.text,
                            currency: _selectedCurrency,
                            icon: _selectedIcon,
                            balance: .parse(
                              _balanceController.text.replaceAll(',', '.'),
                            ),
                            type: _selectedType,
                          );
                        } else {
                          repo.add(
                            name: _nameController.text,
                            currency: _selectedCurrency,
                            icon: _selectedIcon,
                            balance: .parse(
                              _balanceController.text.replaceAll(',', '.'),
                            ),
                            type: _selectedType,
                          );
                        }
                        Navigator.pop(context);
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
