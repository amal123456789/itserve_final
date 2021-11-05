class Validators {
  bool isPasswordValid(String password) => password.length >= 8;

  bool isEmailValid(String email) {
    Pattern pattern = r'^\S+@\S+\.\S+$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isNameValid(String name) {
    Pattern pattern = r'^[A-Za-z0-9]+$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(name);
  }
}
