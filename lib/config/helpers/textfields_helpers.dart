import 'package:flutter/services.dart';

final onlyCharactersFormatter =
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'));

const egyptianPhoneNumberRegex = r'^(11|10|15|12)[0-9]\d{7}';

bool validateEgyptianPhoneNumber(String value) {
  final RegExp regExp = RegExp(egyptianPhoneNumberRegex);
  return regExp.hasMatch(value);
}
