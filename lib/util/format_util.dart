import 'package:intl/intl.dart';

//2022-07-13
final dateFormatter = DateFormat('yyyy-MM-dd');
final fullDateFormatter = DateFormat('d MMM yyy HH:mm:ss');

final _moneyFormat = NumberFormat.currency(
  locale: "en_US",
  symbol: "\$",
  decimalDigits: 0,
);
final _moneyFormatDecimals = NumberFormat.currency(
  locale: "en_US",
  symbol: "\$",
  decimalDigits: 2,
);

String formatMoney(int? amount) {
  return amount == null ? '' : _moneyFormat.format(amount);
}

String formatMoneyDecimals(num amount) {
  return _moneyFormatDecimals.format(amount);
}

int parseMoney(String moneyString) {
  final decodedString = moneyString.replaceAll('\$', '').replaceAll(',', '');
  return int.tryParse(decodedString) ?? 0;
}

int? tryParseMoney(String moneyString) {
  final decodedString = moneyString.replaceAll('\$', '').replaceAll(',', '');
  return int.tryParse(decodedString);
}

String decodePhone(String phoneNumber) {
  return phoneNumber.replaceAll('+', '').replaceAll(' ', '');
}

String dateToExpiryDate(DateTime date) {
  return '${date.month < 10 ? '0' : ''}${date.month}/${date.year % 100}';
}

String nfcIdToString(List<int> byteArray) {
  // List<int> byteArray = [93, 100, 183, 31];
  // String convertedString =
  //     byteArray.map((byte) => byte.toRadixString(16)).join('');

  return byteArray
      .map((byte) => byte.toRadixString(16))
      .join(''); // Output: "5d64b71f"
}

String formatCardNumber(String cardNumber) {
  final chunks = <String>[];
  for (var i = 0; i < cardNumber.length; i += 4) {
    chunks.add(cardNumber.substring(i, i + 4));
  }
  return chunks.join(' ');
}