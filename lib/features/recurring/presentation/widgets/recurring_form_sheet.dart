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
import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';
import 'package:finflow_app/features/recurring/presentation/providers/recurring_providers.dart';
import 'package:finflow_app/features/recurring/presentation/widgets/frequency_selector.dart';
import 'package:finflow_app/features/recurring/presentation/widgets/next_payments_preview.dart';
import 'package:finflow_app/features/transactions/domain/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecurringFormSheet extends ConsumerStatefulWidget {
  final RecurringPayment? payment;

  const RecurringFormSheet({this.payment, super.key});

  @override
  ConsumerState<RecurringFormSheet> createState() => _RecurringFormSheetState();
}

class _RecurringFormSheetState extends ConsumerState<RecurringFormSheet> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _customDaysController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  RecurrenceFrequency _selectedFrequency = RecurrenceFrequency.monthly;
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  String? _selectedCategory;
  String? _selectedAccount;

  bool _isInEditMode = false;

  @override
  void initState() {
    super.initState();
    final p = widget.payment;
    if (p != null) {
      _nameController.text = p.name;
      _amountController.text = p.amount.toString();
      _customDaysController.text = p.customDays?.toString() ?? "";
      _selectedType = p.type;
      _selectedFrequency = p.frequency;
      _startDate = p.startDate;
      _endDate = p.endDate;
      _selectedCategory = p.categoryId;
      _selectedAccount = p.accountId;
      _isInEditMode = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _customDaysController.dispose();
    super.dispose();
  }

  bool get _isCustom => _selectedFrequency == RecurrenceFrequency.custom;

  int? get _parsedCustomDays => int.tryParse(_customDaysController.text);

  /// Difesa UI: un [DropdownButtonFormField] crasha se il suo value non è tra
  /// gli item. Se la categoria/conto collegato non è più disponibile (rimosso,
  /// dato legacy, ecc.) ritorno null → il dropdown mostra vuoto invece di crashare.
  String? _validValue(String? id, Iterable<String> available) =>
      available.contains(id) ? id : null;

  bool get _isFormValid {
    final nameOk = _nameController.text.trim().isNotEmpty;
    final amountOk =
        double.tryParse(_amountController.text.replaceAll(',', '.')) != null;
    final customOk = !_isCustom || (_parsedCustomDays ?? 0) > 0;
    return nameOk && amountOk && customOk;
  }

  /// Pagamento "fittizio" costruito dallo stato corrente per alimentare
  /// l'anteprima delle prossime date. id/category/account non servono al motore.
  RecurringPayment? get _previewPayment {
    if (_isCustom && (_parsedCustomDays ?? 0) <= 0) return null;
    return RecurringPayment(
      id: '',
      name: '',
      amount: 0,
      type: _selectedType,
      categoryId: '',
      accountId: '',
      frequency: _selectedFrequency,
      startDate: _startDate,
      endDate: _endDate,
      customDays: _isCustom ? _parsedCustomDays : null,
    );
  }

  void _save() {
    final repo = ref.read(recurringRepositoryProvider);
    final amount = double.parse(_amountController.text.replaceAll(',', '.'));
    final customDays = _isCustom ? _parsedCustomDays : null;

    if (_isInEditMode) {
      repo.update(
        id: widget.payment!.id,
        name: _nameController.text.trim(),
        amount: amount,
        type: _selectedType,
        frequency: _selectedFrequency,
        startDate: _startDate,
        categoryId: _selectedCategory,
        accountId: _selectedAccount,
        endDate: _endDate,
        customDays: customDays,
      );
    } else {
      repo.add(
        name: _nameController.text.trim(),
        amount: amount,
        type: _selectedType,
        frequency: _selectedFrequency,
        startDate: _startDate,
        categoryId: _selectedCategory,
        accountId: _selectedAccount,
        endDate: _endDate,
        customDays: customDays,
      );
    }
    Navigator.pop(context);
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
    final preview = _previewPayment;

    return Padding(
      padding: EdgeInsets.only(
        left: FFSpacing.lg,
        right: FFSpacing.lg,
        top: FFSpacing.sm,
        bottom: MediaQuery.of(context).viewInsets.bottom + FFSpacing.xl,
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
              _isInEditMode ? "Modifica ricorrente" : "Nuovo ricorrente",
              style: FFTypography.headingMd.copyWith(color: colors.textPrimary),
            ),

            // Toggle tipo (Uscite / Entrate)
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
              label: "Nome",
              hint: "Es. Netflix, Affitto, Stipendio",
              controller: _nameController,
              onChanged: (_) => setState(() {}),
            ),
            FFInput(
              label: "Importo",
              hint: "Inserisci l'importo",
              controller: _amountController,
              textInputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
            ),

            FrequencySelector(
              value: _selectedFrequency,
              onChanged: (freq) => setState(() => _selectedFrequency = freq),
            ),

            // Campo "ogni N giorni": solo per la frequenza personalizzata.
            if (_isCustom)
              FFInput(
                label: "Ogni quanti giorni",
                hint: "Es. 10",
                controller: _customDaysController,
                textInputType: TextInputType.number,
                onChanged: (_) => setState(() {}),
              ),

            FFDatePicker(
              label: "Data inizio",
              value: _startDate,
              onChanged: (value) => setState(() => _startDate = value),
            ),

            FFDatePicker(
              label: "Data fine (opzionale)",
              value: _endDate,
              firstDate: _startDate,
              onChanged: (value) => setState(() => _endDate = value),
            ),
            if (_endDate != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => setState(() => _endDate = null),
                  child: Text(
                    "Rimuovi data fine",
                    style: FFTypography.caption.copyWith(
                      color: colors.semanticNegative,
                    ),
                  ),
                ),
              ),

            // Categoria
            asyncCategories.when(
              data: (categories) => categories.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _validValue(
                              _selectedCategory,
                              categories.map((c) => c.id),
                            ),
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
              error: (err, stack) => Text(
                "Impossibile caricare le categorie.",
                style: FFTypography.caption.copyWith(color: colors.textMuted),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),

            // Conto
            asyncAccounts.when(
              data: (accounts) => accounts.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _validValue(
                              _selectedAccount,
                              accounts.map((a) => a.id),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Conto',
                              labelStyle: FFTypography.caption.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                            items: [
                              for (final a in accounts)
                                DropdownMenuItem(
                                  value: a.id,
                                  child: Text('${a.icon} ${a.name}'),
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
              error: (err, stack) => Text(
                "Impossibile caricare i conti.",
                style: FFTypography.caption.copyWith(color: colors.textMuted),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),

            // Anteprima live delle prossime date (usa il RecurringEngine).
            if (preview != null) NextPaymentsPreview(payment: preview),

            FFButton(
              label: "Salva",
              variant: FFButtonVariant.primary,
              onPressed: _isFormValid ? _save : null,
            ),
          ],
        ),
      ),
    );
  }
}
