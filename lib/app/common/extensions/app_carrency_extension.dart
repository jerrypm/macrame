import 'package:intl/intl.dart';

extension CurrencyFormatExtension on num {
  String toCurrency$({String symbol = '\$', String locale = 'en_US'}) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      locale: locale,
    );
    return formatter.format(this);
  }

  String toCurrencyRP({String symbol = 'Rp', String locale = 'id_ID'}) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      locale: locale,
    );
    String formattedValue = formatter.format(this);

    // Menghapus dua nol di belakang koma
    if (formattedValue.contains(',')) {
      int decimalIndex = formattedValue.indexOf(',');
      if (decimalIndex + 3 <= formattedValue.length) {
        formattedValue = formattedValue.substring(0, decimalIndex + 3);
      }
    }

    // Menghapus ",00" di belakang
    formattedValue = formattedValue.replaceAll(RegExp(r',00$'), '');

    return formattedValue;
  }
}
