import 'package:finflow_app/features/recurring/domain/recurring_engine.dart';
import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';
import 'package:finflow_app/features/transactions/domain/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Helper: un RecurringPayment ha tanti campi obbligatori, ma ai test
  // interessano solo frequency/startDate/endDate/customDays. Questo builder
  // riempie il resto con valori fissi così ogni test resta leggibile.
  RecurringPayment buildPayment({
    required RecurrenceFrequency frequency,
    required DateTime startDate,
    DateTime? endDate,
    int? customDays,
  }) {
    return RecurringPayment(
      id: '1',
      name: 'Test',
      amount: 10,
      type: TransactionType.expense,
      categoryId: 'c1',
      accountId: 'a1',
      frequency: frequency,
      startDate: startDate,
      endDate: endDate,
      customDays: customDays,
    );
  }

  group('occurrencesBetween', () {
    test('weekly returns a date every 7 days within the range', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.weekly,
        startDate: DateTime(2026, 1, 1),
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2026, 1, 1),
        DateTime(2026, 1, 31),
      );

      expect(result, [
        DateTime(2026, 1, 1),
        DateTime(2026, 1, 8),
        DateTime(2026, 1, 15),
        DateTime(2026, 1, 22),
        DateTime(2026, 1, 29),
      ]);
    });
    test('monthly returns a date for each month within the range', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.monthly,
        startDate: DateTime(2026, 1, 15),
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2026, 1, 1),
        DateTime(2026, 4, 30),
      );

      expect(result, [
        DateTime(2026, 1, 15),
        DateTime(2026, 2, 15),
        DateTime(2026, 3, 15),
        DateTime(2026, 4, 15),
      ]);
    });
    test(
      'monthly returns a date for each month within the range, using not common days',
      () {
        final payment = buildPayment(
          frequency: RecurrenceFrequency.monthly,
          startDate: DateTime(2026, 1, 31),
        );

        final result = RecurringEngine.occurrencesBetween(
          payment,
          DateTime(2026, 1, 1),
          DateTime(2026, 5, 31),
        );

        expect(result, [
          DateTime(2026, 1, 31),
          DateTime(2026, 2, 28),
          DateTime(2026, 3, 31),
          DateTime(2026, 4, 30),
          DateTime(2026, 5, 31),
        ]);
      },
    );

    test('stops at endDate (inclusive) even if the range extends further', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.monthly,
        startDate: DateTime(2026, 1, 15),
        endDate: DateTime(2026, 3, 15),
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2026, 1, 1),
        DateTime(2026, 12, 31),
      );

      expect(result, [
        DateTime(2026, 1, 15),
        DateTime(2026, 2, 15),
        DateTime(2026, 3, 15),
      ]);
    });

    test('biweekly returns a date every 14 days', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.biweekly,
        startDate: DateTime(2026, 1, 1),
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2026, 1, 1),
        DateTime(2026, 2, 1),
      );

      expect(result, [
        DateTime(2026, 1, 1),
        DateTime(2026, 1, 15),
        DateTime(2026, 1, 29),
      ]);
    });

    test('quarterly advances 3 months at a time, with day clamping', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.quarterly,
        startDate: DateTime(2026, 1, 31),
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2026, 1, 1),
        DateTime(2026, 12, 31),
      );

      expect(result, [
        DateTime(2026, 1, 31),
        DateTime(2026, 4, 30), // aprile non ha il 31 → clamp
        DateTime(2026, 7, 31),
        DateTime(2026, 10, 31),
      ]);
    });

    test('annual on Feb 29 clamps to Feb 28 on non-leap years', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.annual,
        startDate: DateTime(2024, 2, 29), // 2024 bisestile
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2024, 1, 1),
        DateTime(2028, 12, 31),
      );

      expect(result, [
        DateTime(2024, 2, 29),
        DateTime(2025, 2, 28), // non bisestile → clamp
        DateTime(2026, 2, 28),
        DateTime(2027, 2, 28),
        DateTime(2028, 2, 29), // di nuovo bisestile
      ]);
    });

    test('custom uses customDays as the step', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.custom,
        startDate: DateTime(2026, 1, 1),
        customDays: 10,
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2026, 1, 1),
        DateTime(2026, 2, 1),
      );

      expect(result, [
        DateTime(2026, 1, 1),
        DateTime(2026, 1, 11),
        DateTime(2026, 1, 21),
        DateTime(2026, 1, 31),
      ]);
    });

    test('returns only occurrences inside the window when the payment '
        'started before it', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.monthly,
        startDate: DateTime(2025, 6, 10), // iniziato molto prima del range
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2026, 1, 1),
        DateTime(2026, 3, 31),
      );

      expect(result, [
        DateTime(2026, 1, 10),
        DateTime(2026, 2, 10),
        DateTime(2026, 3, 10),
      ]);
    });

    test('day-based: started years before, from lands mid-stream', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.weekly,
        startDate: DateTime(2020, 1, 1), // ~6 anni prima
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2026, 1, 1),
        DateTime(2026, 1, 31),
      );

      // 2020-01-01 + N*7gg: la prima occorrenza dentro gennaio 2026
      expect(result, [
        DateTime(2026, 1, 7),
        DateTime(2026, 1, 14),
        DateTime(2026, 1, 21),
        DateTime(2026, 1, 28),
      ]);
    });

    test('month-based: started years before, anchoring + clamp preserved', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.quarterly,
        startDate: DateTime(2020, 1, 31), // giorno 31 + trimestrale
      );

      final result = RecurringEngine.occurrencesBetween(
        payment,
        DateTime(2026, 2, 1),
        DateTime(2026, 12, 31),
      );

      // ancora al 31, clamp dove non esiste: apr/ott=30... aspetta, vediamo:
      // 2020-01-31 + k*3 mesi anchored: ... 2026-01-31, 2026-04-30, 2026-07-31, 2026-10-31
      // from = 1 feb → la prima dentro la finestra è aprile
      expect(result, [
        DateTime(2026, 4, 30),
        DateTime(2026, 7, 31),
        DateTime(2026, 10, 31),
      ]);
    });
  });

  group('nextOccurrences', () {
    test('returns the next N occurrences on or after `from`', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.monthly,
        startDate: DateTime(2026, 1, 15),
      );

      final result = RecurringEngine.nextOccurrences(
        payment,
        from: DateTime(2026, 1, 1),
        count: 3,
      );

      expect(result, [
        DateTime(2026, 1, 15),
        DateTime(2026, 2, 15),
        DateTime(2026, 3, 15),
      ]);
    });

    test('returns fewer than N when the payment ends before reaching count', () {
      final payment = buildPayment(
        frequency: RecurrenceFrequency.monthly,
        startDate: DateTime(2026, 1, 15),
        endDate: DateTime(2026, 2, 15),
      );

      final result = RecurringEngine.nextOccurrences(
        payment,
        from: DateTime(2026, 1, 1),
        count: 5,
      );

      expect(result, [
        DateTime(2026, 1, 15),
        DateTime(2026, 2, 15),
      ]);
    });
  });
}
