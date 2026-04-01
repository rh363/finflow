import 'package:drift/drift.dart';
import 'package:finflow_app/features/accounts/domain/account.dart';
import 'package:finflow_app/features/recurring/domain/recurring_payment.dart';
import 'package:finflow_app/features/transactions/domain/transaction.dart';

class TransactionTypeConverter extends TypeConverter<TransactionType, int> {
  const TransactionTypeConverter();

  @override
  TransactionType fromSql(int fromDb) {
    return TransactionType.values[fromDb];
  }

  @override
  int toSql(TransactionType value) {
    return value.index;
  }
}

class AccountTypeConverter extends TypeConverter<AccountType, int> {
  const AccountTypeConverter();

  @override
  AccountType fromSql(int fromDb) {
    return AccountType.values[fromDb];
  }

  @override
  int toSql(AccountType value) {
    return value.index;
  }
}

class RecurrenceFrequencyConverter
    extends TypeConverter<RecurrenceFrequency, int> {
  const RecurrenceFrequencyConverter();

  @override
  RecurrenceFrequency fromSql(int fromDb) {
    return RecurrenceFrequency.values[fromDb];
  }

  @override
  int toSql(RecurrenceFrequency value) {
    return value.index;
  }
}
