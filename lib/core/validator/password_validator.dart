passwordValidator(String value) {
  if (value.isEmpty) {
    return "Password is required";
  }
  if (value.length < 6) {
    return "Password must be at least 6 characters";
  }
  if(!RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$').hasMatch(value)){
    return "Password must contain at least one uppercase letter, one lowercase letter and one number";
  }
  return null;
}