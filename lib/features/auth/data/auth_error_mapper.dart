import 'package:spend_smart/core/utils/string.dart';

class AuthErrorMapper {
  static String map(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return AppString.emailAlreadyInUse;
      case 'invalid-email':
        return AppString.invalidEmail;
      case 'invalid-credential':
        return AppString.invalidCredential;
      case 'weak-password':
        return AppString.weakPassword;
      case 'user-disabled':
        return AppString.userDisabled;
      case 'user-not-found':
        return AppString.userNotFound;
      case 'wrong-password':
        return AppString.wrongPassword;
      case 'too-many-requests':
        return AppString.tooManyRequests;
      case 'operation-not-allowed':
        return AppString.operationNotAllowed;
      case 'network-request-failed':
        return AppString.networkRequestFailed;
      default:
        return AppString.unexpectedError;
    }
  }
}
