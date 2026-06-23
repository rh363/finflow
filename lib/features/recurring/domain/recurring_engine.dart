import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';

abstract final class RecurringEngine {
  /// Tutte le occorrenze comprese tra [from] e [to] (estremi inclusi),
  /// limitate da `payment.endDate` se presente.
  static List<DateTime> occurrencesBetween(
    RecurringPayment payment,
    DateTime from,
    DateTime to,
  ) {
    _validate(payment);

    final occurrences = <DateTime>[];
    final end = (payment.endDate != null && payment.endDate!.isBefore(to))
        ? payment.endDate!
        : to;

    var cursor = _initialCursor(payment, from);

    while (cursor.isBefore(end) || cursor.isAtSameMomentAs(end)) {
      if (cursor.isAfter(from) || cursor.isAtSameMomentAs(from)) {
        occurrences.add(cursor);
      }
      cursor = _advance(payment, cursor);
    }
    return occurrences;
  }

  /// Le prossime [count] occorrenze a partire da [from] (inclusa).
  /// Può restituirne meno di [count] se il pagamento termina prima (endDate).
  static List<DateTime> nextOccurrences(
    RecurringPayment payment, {
    required DateTime from,
    required int count,
  }) {
    _validate(payment);

    final result = <DateTime>[];
    var cursor = _initialCursor(payment, from);
    final end = payment.endDate;

    while (result.length < count) {
      if (end != null && cursor.isAfter(end)) break;
      if (!cursor.isBefore(from)) result.add(cursor);
      cursor = _advance(payment, cursor);
    }
    return result;
  }

  static void _validate(RecurringPayment payment) {
    if (payment.frequency == RecurrenceFrequency.custom &&
        payment.customDays == null) {
      throw ArgumentError(
        "Detected a Custom recurrence frequency with no custom days set",
      );
    }
  }

  /// Avanza il cursore di un passo secondo la frequenza del pagamento.
  static DateTime _advance(RecurringPayment payment, DateTime cursor) {
    final anchorDay = payment.startDate.day;
    return switch (payment.frequency) {
      RecurrenceFrequency.weekly => DateTime(
        cursor.year,
        cursor.month,
        cursor.day + 7,
      ),
      RecurrenceFrequency.biweekly => DateTime(
        cursor.year,
        cursor.month,
        cursor.day + 14,
      ),
      RecurrenceFrequency.custom => DateTime(
        cursor.year,
        cursor.month,
        cursor.day + payment.customDays!,
      ),
      RecurrenceFrequency.monthly => _addMonthsAnchored(cursor, 1, anchorDay),
      RecurrenceFrequency.bimonthly => _addMonthsAnchored(cursor, 2, anchorDay),
      RecurrenceFrequency.quarterly => _addMonthsAnchored(cursor, 3, anchorDay),
      RecurrenceFrequency.semiannual => _addMonthsAnchored(cursor, 6, anchorDay),
      RecurrenceFrequency.annual => _addMonthsAnchored(cursor, 12, anchorDay),
    };
  }

  static DateTime _addMonthsAnchored(
    DateTime cursor,
    int months,
    int anchorDay,
  ) {
    final year = cursor.year;
    final month = cursor.month + months;

    final lastDayOfTargetMonth = DateTime(year, month + 1, 0).day;
    final day = anchorDay <= lastDayOfTargetMonth
        ? anchorDay
        : lastDayOfTargetMonth;

    return DateTime(year, month, day);
  }

  /// Salta direttamente all'ultima occorrenza ≤ [from], così il loop non
  /// "striscia" da startDate. Usa la divisione intera (floor) per sotto-stimare
  /// il numero di passi: non supera mai un'occorrenza dentro la finestra.
  static DateTime _initialCursor(RecurringPayment payment, DateTime from) {
    final start = payment.startDate;
    if (!from.isAfter(start)) return start; // from <= start → niente da saltare

    return switch (payment.frequency) {
      RecurrenceFrequency.weekly => _jumpDays(start, from, 7),
      RecurrenceFrequency.biweekly => _jumpDays(start, from, 14),
      RecurrenceFrequency.custom => _jumpDays(start, from, payment.customDays!),
      RecurrenceFrequency.monthly => _jumpMonths(start, from, 1),
      RecurrenceFrequency.bimonthly => _jumpMonths(start, from, 2),
      RecurrenceFrequency.quarterly => _jumpMonths(start, from, 3),
      RecurrenceFrequency.semiannual => _jumpMonths(start, from, 6),
      RecurrenceFrequency.annual => _jumpMonths(start, from, 12),
    };
  }

  static DateTime _jumpDays(DateTime start, DateTime from, int stepDays) {
    final diff = DateTime(
      from.year,
      from.month,
      from.day,
    ).difference(DateTime(start.year, start.month, start.day)).inDays;
    final k = diff ~/ stepDays; // floor
    return DateTime(start.year, start.month, start.day + k * stepDays);
  }

  static DateTime _jumpMonths(DateTime start, DateTime from, int stepMonths) {
    final monthsDiff =
        (from.year - start.year) * 12 + (from.month - start.month);
    final k = monthsDiff ~/ stepMonths; // floor
    return _addMonthsAnchored(start, k * stepMonths, start.day);
  }
}