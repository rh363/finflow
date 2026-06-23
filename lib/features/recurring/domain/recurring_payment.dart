import 'package:finflow_app/features/transactions/domain/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_payment.freezed.dart';

enum RecurrenceFrequency {
  weekly,
  biweekly,
  monthly,
  bimonthly,
  quarterly,
  semiannual,
  annual,
  custom,
}

extension RecurrenceFrequencyLabel on RecurrenceFrequency {
  String get label => switch (this) {
    RecurrenceFrequency.weekly => "Settimanale",
    RecurrenceFrequency.biweekly => "Ogni 2 settimane",
    RecurrenceFrequency.monthly => "Mensile",
    RecurrenceFrequency.bimonthly => "Bimestrale",
    RecurrenceFrequency.quarterly => "Trimestrale",
    RecurrenceFrequency.semiannual => "Semestrale",
    RecurrenceFrequency.annual => "Annuale",
    RecurrenceFrequency.custom => "Personalizzata",
  };
}

@freezed
abstract class RecurringPayment with _$RecurringPayment {
  const factory RecurringPayment({
    required String id,
    required String name,
    required double amount,
    required TransactionType type,
    String? categoryId,
    String? accountId,
    required RecurrenceFrequency frequency,
    required DateTime startDate,
    DateTime? endDate,
    int? customDays,
  }) = _RecurringPayment;
}
