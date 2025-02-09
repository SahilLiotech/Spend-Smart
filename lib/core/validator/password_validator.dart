import 'package:spend_smart/core/utils/string.dart';

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return AppString.passwordRequired;
  if (value.length < 6) return AppString.passwordTooShort;
  if (!RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
      .hasMatch(value)) {
    return AppString.passwordRequirements;
  }
  return null;
}
