class AuthExecption implements Exception {
  final String message;

  AuthExecption(this.message);
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);
}

class ErrorException implements Exception {
  final String message;

  ErrorException(this.message);
}
