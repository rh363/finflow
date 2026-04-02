import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/features/categories/presentation/providers/categories_providers.dart';
import 'package:finflow_app/features/categories/presentation/widgets/add_category_sheet.dart';
import 'package:finflow_app/features/categories/presentation/widgets/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.ffColors;
    final futureCategories = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categorie",
          style: FFTypography.displaySm.copyWith(color: colors.textPrimary),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: futureCategories.whenOrNull(
        data: (d) => FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const AddCategorySheet(),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: FFSpacing.xxl,
          horizontal: FFSpacing.md,
        ),
        child: futureCategories.when(
          data: (categories) => categories.isNotEmpty
              ? GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: FFSpacing.md,
                  crossAxisSpacing: FFSpacing.md,
                  children: [
                    for (final c in categories)
                      CategoryChip(
                        icon: c.icon,
                        label: c.name,
                        isSelected: c.isDefault,
                        onTap: () {},
                      ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Nessuna categoria presente.",
                        style: FFTypography.headingMd.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        "Clicca sul '+' per aggiungerne una.",
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
                    "Impossibile caricare le categorie.",
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
