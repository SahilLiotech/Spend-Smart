String? confirmPasswordValidator(String? currentPassword, String? previousPassword) {
  if (currentPassword != previousPassword) {
    return "Confirm Password must be the same as Password";
  }
  return null;
}