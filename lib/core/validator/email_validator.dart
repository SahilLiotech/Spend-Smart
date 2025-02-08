String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Email is required";
  }
  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(value)) {
    return "Invalid email";
  }
  return null;
}
