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

@freezed
abstract class RecurringPayment with _$RecurringPayment {
  const factory RecurringPayment({
    required String id,
    required String name,
    required double amount,
    required TransactionType type,
    required String categoryId,
    required String accountId,
    required RecurrenceFrequency frequency,
    required DateTime startDate,
    DateTime? endDate,
    int? customDays,
  }) = _RecurringPayment;
}
