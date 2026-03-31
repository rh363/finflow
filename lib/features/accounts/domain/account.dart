import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

enum AccountType { checking, creditCard, cash, saving }

@freezed
abstract class Account with _$Account {
  const factory Account({
    required String id,
    required String name,
    required AccountType type,
    required double balance,
    required String currency,
    required String icon,
  }) = _Account;
}
