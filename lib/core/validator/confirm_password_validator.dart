import 'package:spend_smart/core/utils/string.dart';

String? confirmPasswordValidator(String? currentPassword, String? previousPassword) {
  if (currentPassword != previousPassword) {
    return AppString.confirmPasswordMismatch;
  }
  return null;
}