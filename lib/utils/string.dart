import 'package:intl/intl.dart';
import 'package:validators/validators.dart';

class StringUtil {
  static final compactCurrencyFormat =
  NumberFormat.compactLong(locale: "en_US");
  static final currencyFormat = NumberFormat.currency(locale: "en_NG");
  static final nairaFormat =
  NumberFormat.currency(locale: "en_NG", symbol: "₦");
  static bool isPhone(value) => matches(value, r'^(\+?234|0)?[789]\d{9}$');
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalize => split(" ").map((str) => str.inCaps).join(" ");
}

extension DecimalPlaces on num {
  String get zeroPlaces => toStringAsFixed(0);
  String toDecimalPlaces(int fractionDigits) {
    return toStringAsFixed(fractionDigits);
  }
}

extension MoneyExtension on String {
  String get stripLocale => substring(3);
}

String _splitNumber(String s) {
  var sa = s.split('');
  var n = '';
  var i = 0;
  for (var v in sa) {
    if(i < 4) {
      n += v;
      i += 1;
    } else {
      n += '-'+ v;
      i = 1;
    }
  }
  return n;
}

String splitNumber(String number) {
  print('number...........$number');
  String numberString = number;
  String formattedNumber = '';

  for (int i = 0; i < numberString.length; i += 4) {
    int endIndex = i + 4;
    if (endIndex > numberString.length) {
      endIndex = numberString.length;
    }
    String group = numberString.substring(i, endIndex);
    formattedNumber += group;

    if (endIndex < numberString.length) {
      formattedNumber += '-';
    }
  }

  return formattedNumber;
}

String toSentenceCase(String input) {
  String lowercase = input.toLowerCase();
  String result = lowercase.replaceAllMapped(
      RegExp("(^|\\.)\\s*([a-z])"),
          (match) => "${match.group(1)}${match.group(2)!.toUpperCase()}");
  result = result.replaceFirst(result[0], result[0].toUpperCase());
  return result;
}

String toSentenceCases(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

String spaceNumber(String s) {
  var sa = s.split('');
  var n = '';
  var i = 0;
  for (var v in sa) {
    if(i < 4) {
      n += v;
      i += 1;
    } else {
      n += ' '+ v;
      i = 1;
    }
  }
  return n;
}