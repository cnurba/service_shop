import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  /// Formats the double as a currency string with two decimal places and a currency symbol.

  /// [intl] package is required for this method to work.
  /// Formats the double as a localized currency string.
  String toCurrencyString() {
    // Uncomment the following lines if the intl package is available.
    final format = NumberFormat.compactCurrency();
    return format.format(this);
  }

}