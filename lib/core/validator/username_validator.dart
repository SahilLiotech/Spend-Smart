String? userNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Username can\'t be empty';
  }
  if (value.length < 3) {
    return 'Username must be at least 3 characters long';
  }
  if (value.length > 20) {
    return 'Username must be less than 20 characters';
  }
  return null;
}
