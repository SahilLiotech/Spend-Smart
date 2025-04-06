class AuthExecption implements Exception {
  final String message;

  AuthExecption(this.message);
}

class CustomTimeOutException implements Exception {
  final String message;

  CustomTimeOutException(this.message);
}

class ErrorException implements Exception {
  final String message;

  ErrorException(this.message);
}
