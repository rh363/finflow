import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/widgets/ff_button.dart';
import 'package:finflow_app/core/widgets/ff_input.dart';
import 'package:finflow_app/features/categories/domain/category.dart';
import 'package:finflow_app/features/categories/presentation/providers/categories_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorySheet extends ConsumerStatefulWidget {
  final Category? category;

  const CategorySheet({this.category, super.key});

  @override
  ConsumerState<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends ConsumerState<CategorySheet> {
  final _nameController = TextEditingController();
  String _selectedEmoji = '🏠';
  bool _isNameValid = false;

  static const _emojis = [
    '🏠',
    '🚗',
    '🍕',
    '💻',
    '🎮',
    '💊',
    '💰',
    '📚',
    '⚡',
    '🛒',
    '🎵',
    '👕',
    '✈️',
  ];

  bool _isSelectedEmoji(String emoji) => _selectedEmoji == emoji;

  bool get _isInEditMode => widget.category != null;

  @override
  void initState() {
    super.initState();
    final cat = widget.category;
    if (cat != null) {
      _nameController.text = cat.name;
      _selectedEmoji = cat.icon;
      _isNameValid = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
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
            _isInEditMode ? "Modifica categoria" : "Nuova categoria",
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
                  _isNameValid = value.isNotEmpty;
                });
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
                    _selectedEmoji = emoji;
                  }),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _isSelectedEmoji(emoji)
                          ? colors.accentBg
                          : colors.bgCardAlt,
                      border: Border.all(
                        color: _isSelectedEmoji(emoji)
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
          const SizedBox(height: FFSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: FFButton(
              label: "Salva",
              variant: FFButtonVariant.primary,
              onPressed: _isNameValid
                  ? () {
                      final repo = ref.read(categoriesRepositoryProvider);
                      if (_isInEditMode) {
                        final c = widget.category!;
                        repo.update(
                          id: int.parse(c.id),
                          name: _nameController.text,
                          icon: _selectedEmoji,
                          color: colors.bgCardAlt.hashCode,
                        );
                      } else {
                        repo.add(
                          name: _nameController.text,
                          icon: _selectedEmoji,
                          color: colors.bgCardAlt.hashCode,
                        );
                      }
                      Navigator.pop(context);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
