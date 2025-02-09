import 'package:spend_smart/core/utils/string.dart';

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return AppString.emailRequired;
  }
  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(value)) {
    return AppString.invalidEmail;
  }
  return null;
}
