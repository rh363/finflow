import 'package:finflow_app/core/constants/currency_constants.dart';
import 'package:intl/intl.dart';

abstract final class CurrencyUtils {
  static String formatCurrency(double amount, String currency) {
    if (CurrencyConstants.currencies.containsKey(currency)) {
      currency = CurrencyConstants.currencies[currency]!;
    }
    return NumberFormat.currency(
      locale: 'it_IT',
      symbol: currency,
      decimalDigits: 2,
    ).format(amount);
  }
}
