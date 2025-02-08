emailValidator(String value){
  if(value.isEmpty){
    return "Email is required";
  }
  if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
    return "Invalid email";
  }
  return null;
}