import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

bool emailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool phoneValid(String phoneNumber) {
  return isPhoneValid(phoneNumber);
}

bool cardNumberValid(String cardNumber) {
  final result = CreditCardValidator().validateCCNum(cardNumber);
  return result.isValid;
}