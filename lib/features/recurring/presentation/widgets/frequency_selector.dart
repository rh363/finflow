import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';
import 'package:flutter/material.dart';

/// Selettore della frequenza di ricorrenza.
///
/// Widget "controllato": riceve [value] e notifica le scelte via [onChanged],
/// come i dropdown di categoria/conto del form transazioni.
class FrequencySelector extends StatelessWidget {
  final RecurrenceFrequency value;
  final ValueChanged<RecurrenceFrequency> onChanged;

  const FrequencySelector({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;

    return DropdownButtonFormField<RecurrenceFrequency>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: 'Frequenza',
        labelStyle: FFTypography.caption.copyWith(color: colors.textMuted),
      ),
      items: [
        for (final freq in RecurrenceFrequency.values)
          DropdownMenuItem(value: freq, child: Text(freq.label)),
      ],
      onChanged: (freq) {
        if (freq != null) onChanged(freq);
      },
    );
  }
}
