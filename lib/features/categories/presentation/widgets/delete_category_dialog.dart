import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/widgets/ff_button.dart';
import 'package:finflow_app/features/categories/domain/category.dart';
import 'package:finflow_app/features/categories/presentation/providers/categories_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteCategoryDialog extends ConsumerWidget {
  final Category category;

  const DeleteCategoryDialog({required this.category, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.ffColors;
    return AlertDialog(
      title: Text(
        'Elimina categoria',
        style: FFTypography.headingMd.copyWith(color: colors.textPrimary),
      ),
      content: Text(
        "Vuoi eliminare '${category.name}'?",
        style: FFTypography.bodyMd.copyWith(color: colors.textPrimary),
      ),
      actions: [
        FFButton(
          label: "Elimina",
          variant: FFButtonVariant.destructive,
          onPressed: () {
            final repo = ref.read(categoriesRepositoryProvider);
            repo.delete(category.id);
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
