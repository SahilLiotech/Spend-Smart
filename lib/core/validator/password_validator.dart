String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return "Password is required";
  if (value.length < 6) return "Must be at least 6 characters";
  if (!RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
      .hasMatch(value)) {
    return "Must include uppercase, lowercase, number & symbol";
  }
  return null;
}
