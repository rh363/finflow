import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FFDatePicker extends StatelessWidget {
  final ValueChanged<DateTime> onChanged;
  final String? label;
  final DateTime? value;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const FFDatePicker({
    required this.onChanged,
    this.value,
    this.label,
    this.firstDate,
    this.lastDate,
    super.key,
  });

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: value,
      firstDate:
          firstDate ?? DateTime.now().subtract(const Duration(days: 360 * 10)),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 360 * 10)),
    );
    // se l'utente ha scelto, NON fai setState (non hai stato!):
    // avvisi il genitore tramite la callback
    if (picked != null) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: FFTypography.caption.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: 6),
        ],
        InkWell(
          borderRadius: FFRadius.xs,
          onTap: () => _pickDate(context),
          child: Container(
            decoration: BoxDecoration(
              color: colors.bgCardAlt,
              border: Border.all(width: 1, color: colors.borderDefault),
              borderRadius: FFRadius.xs,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null
                      ? DateFormat('dd MMM yyyy', 'it_IT').format(value!)
                      : "Nessuna data selezionata",
                  style: FFTypography.bodyMd.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                Icon(LucideIcons.calendar, color: colors.textMuted),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
