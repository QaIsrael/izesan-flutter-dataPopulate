import 'package:izesan/utils/string.dart';
import 'package:validators/validators.dart';

class Validator {
  Validator(); //class can't be used as a mixin
  late String confirmPass = '';

  static String? phone(value) {
    if (value.isEmpty) {
      return 'Please provide a phone number!';
    }
    if (value.length == 11 && !StringUtil.isPhone(value)) {
      return 'Please enter a valid phone number!';
    }
    return null;
  }

  static String? intlPhone(value) {
    RegExp regExp = RegExp(
        r"^\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}");

    if (value.isNotEmpty) {
      return 'Please provide a Valid phone number!';
    }
    if (value['number'].length == 10 && !regExp.hasMatch(value)) {
      return ("Please Enter a valid Number");
    }
    return null;
  }

  static String? email(value) {
    if (value.isEmpty) {
      return 'Please provide your email address!';
    }
    if (!isEmail(value)) {
      return 'Please enter a valid email!';
    }
    return null;
  }

  static String? cvv(value) {
    if (value.isEmpty) {
      return 'Please provide your CVV!';
    }
    if (value.length < 3 || value.length > 3) {
      return 'Please enter a valid cvv!';
    }
    return null;
  }

  static String? loginPasswordValidation(value) {
    if (value.isEmpty) {
      return 'Please provide your password!';
    }
    return null;
  }

  static String? emailValidate(value) {
    RegExp regEx = RegExp(r"^[a-zA-Z\d+_.-]+@[a-zA-Z\d.-]+.[a-z]");
    if (value.isEmpty) {
      return ("Please Enter Your Email");
    }
    // reg expression for email validation
    if (!regEx.hasMatch(value)) {
      return ("Please Enter a valid email");
    }
    return null;
  }

  static String? password(value) {
    RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+"), // check letter case
        regExNum = RegExp(r"\d"),
        regExSym = RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/,><:;_~`+=]');
    if (value.isEmpty) {
      return 'Please provide your password!';
    }
    if (value.length < 8 || value.length > 30) {
      return 'At least 8 characters';
    } else {
      if (!regEx.hasMatch(value)) {
        return 'Password must have a capital and \na small letter';
      }
      if (!regExNum.hasMatch(value) || !regExSym.hasMatch(value)) {
        return 'Password must have a symbol and number';
      }
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please provide a password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? equalText(value) {
    if (value!.isEmpty) return 'Please confirm your new password!';
    return null;
  }

  static String? noEmptyText(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? noEmptyDropdown(value) {
    if (value == null || value.isEmpty) {
      return 'Please select an option';
    }
    return null;
  }

  static int? differenceOfTwoDates(DateTime startDate, DateTime endDate) {
    startDate = DateTime(startDate.year, startDate.month, startDate.day);
    endDate = DateTime(endDate.year, endDate.month, endDate.day);
    return startDate.difference(endDate).inDays;
  }
}
