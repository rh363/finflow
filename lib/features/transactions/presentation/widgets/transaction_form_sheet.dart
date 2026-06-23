import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/widgets/ff_button.dart';
import 'package:finflow_app/core/widgets/ff_date_picker.dart';
import 'package:finflow_app/core/widgets/ff_input.dart';
import 'package:finflow_app/features/accounts/presentation/providers/accounts_providers.dart';
import 'package:finflow_app/features/accounts/presentation/widgets/account_form_sheet.dart';
import 'package:finflow_app/features/categories/presentation/providers/categories_providers.dart';
import 'package:finflow_app/features/categories/presentation/widgets/category_form_sheet.dart';
import 'package:finflow_app/features/transactions/domain/transaction.dart';
import 'package:finflow_app/features/transactions/presentation/providers/transactions_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionFormSheet extends ConsumerStatefulWidget {
  final Transaction? transaction;

  const TransactionFormSheet({this.transaction, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionFormSheetState();
}

class _TransactionFormSheetState extends ConsumerState<TransactionFormSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  TransactionType _selectedType = TransactionType.expense;
  DateTime _selectedDate = DateTime.now();
  String? _selectedCategory;
  String? _selectedAccount;

  bool _isAmountValid = false;

  bool _isInEditMode = false;

  bool get _isFormValid => _isAmountValid;

  @override
  void initState() {
    super.initState();
    final tra = widget.transaction;
    if (tra != null) {
      _amountController.text = tra.amount.toString();
      _noteController.text = tra.notes ?? "";
      _selectedType = tra.type;
      _selectedDate = tra.date;
      _selectedCategory = tra.categoryId;
      _selectedAccount = tra.accountId;

      _isAmountValid = true;

      _isInEditMode = true;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _openCategoryForm() async {
    final newId = await showModalBottomSheet<String>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) => const CategoryFormSheet(),
    );
    if (newId != null && mounted) {
      setState(() => _selectedCategory = newId);
    }
  }

  Future<void> _openAccountForm() async {
    final newId = await showModalBottomSheet<String>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) => const AccountFormSheet(),
    );
    if (newId != null && mounted) {
      setState(() => _selectedAccount = newId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;
    final asyncCategories = ref.watch(categoriesProvider);
    final asyncAccounts = ref.watch(accountsProvider);

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
          spacing: FFSpacing.lg,
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
            Text(
              _isInEditMode ? "Modifica transazione" : "Nuova transazione",
              style: FFTypography.headingMd.copyWith(color: colors.textPrimary),
            ),
            Row(
              spacing: FFSpacing.lg,
              children: [
                for (final tType in TransactionType.values)
                  Expanded(
                    child: FFButton(
                      label: tType.label,
                      variant: _selectedType == tType
                          ? FFButtonVariant.primary
                          : FFButtonVariant.secondary,
                      onPressed: () {
                        if (_selectedType != tType) {
                          setState(() => _selectedType = tType);
                        }
                      },
                    ),
                  ),
              ],
            ),
            FFInput(
              label: "Importo",
              hint: "Inserisci l'importo della transazione",
              controller: _amountController,
              onChanged: (value) {
                final valid =
                    value.isNotEmpty &&
                    double.tryParse(value.replaceAll(",", ".")) != null;
                if (_isAmountValid != valid) {
                  setState(() => _isAmountValid = valid);
                }
              },
            ),
            FFDatePicker(
              label: "Data",
              value: _selectedDate,
              onChanged: (value) => setState(() => _selectedDate = value),
            ),
            asyncCategories.when(
              data: (categories) => categories.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedCategory,
                            decoration: InputDecoration(
                              labelText: 'Categoria',
                              labelStyle: FFTypography.caption.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                            items: [
                              for (final c in categories)
                                DropdownMenuItem(
                                  value: c.id,
                                  child: Text('${c.icon} ${c.name}'),
                                ),
                            ],
                            onChanged: (value) =>
                                setState(() => _selectedCategory = value),
                          ),
                        ),
                        const SizedBox(width: FFSpacing.sm),
                        IconButton(
                          tooltip: 'Nuova categoria',
                          onPressed: _openCategoryForm,
                          icon: Icon(Icons.add, color: colors.accentDefault),
                        ),
                      ],
                    )
                  : FFButton(
                      label: "Crea una categoria",
                      variant: FFButtonVariant.secondary,
                      onPressed: _openCategoryForm,
                    ),
              error: (err, stack) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Impossibile caricare le categorie.",
                      style: FFTypography.headingMd.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: FFSpacing.xs),
                    Text(
                      "Errore: $err",
                      style: FFTypography.caption.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
            asyncAccounts.when(
              data: (accounts) => accounts.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedAccount,
                            decoration: InputDecoration(
                              labelText: 'Conto',
                              labelStyle: FFTypography.caption.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                            items: [
                              for (final c in accounts)
                                DropdownMenuItem(
                                  value: c.id,
                                  child: Text('${c.icon} ${c.name}'),
                                ),
                            ],
                            onChanged: (value) =>
                                setState(() => _selectedAccount = value),
                          ),
                        ),
                        const SizedBox(width: FFSpacing.sm),
                        IconButton(
                          tooltip: 'Nuovo conto',
                          onPressed: _openAccountForm,
                          icon: Icon(Icons.add, color: colors.accentDefault),
                        ),
                      ],
                    )
                  : FFButton(
                      label: "Crea un conto",
                      variant: FFButtonVariant.secondary,
                      onPressed: _openAccountForm,
                    ),
              error: (err, stack) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Impossibile caricare i conti.",
                      style: FFTypography.headingMd.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: FFSpacing.xs),
                    Text(
                      "Errore: $err",
                      style: FFTypography.caption.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
            FFInput(
              label: "Note",
              hint: "Inserisci una descrizione della spesa",
              controller: _noteController,
              maxLength: 280,
              maxLines: 4,
              textInputType: TextInputType.multiline,
            ),
            FFButton(
              label: "Salva",
              variant: FFButtonVariant.primary,
              onPressed: _isFormValid
                  ? () {
                      final repo = ref.read(transactionsRepositoryProvider);
                      if (_isInEditMode) {
                        repo.update(
                          id: widget.transaction!.id,
                          amount: .parse(
                            _amountController.text.replaceAll(',', '.'),
                          ),
                          type: _selectedType,
                          date: _selectedDate,
                          categoryId: _selectedCategory,
                          accountId: _selectedAccount,
                          notes: _noteController.text.isEmpty
                              ? null
                              : _noteController.text,
                        );
                      } else {
                        repo.add(
                          amount: .parse(
                            _amountController.text.replaceAll(',', '.'),
                          ),
                          type: _selectedType,
                          date: _selectedDate,
                          categoryId: _selectedCategory,
                          accountId: _selectedAccount,
                          notes: _noteController.text.isEmpty
                              ? null
                              : _noteController.text,
                        );
                      }
                      Navigator.pop(context);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
