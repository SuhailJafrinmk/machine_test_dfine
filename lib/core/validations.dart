class ValidatorFunctions{
  static String? validateEmail(String? value) {
        final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!emailRegExp.hasMatch(value)) {
    }
    return null;
  }


  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
    );
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 6 characters and include letters and numbers';
    }
    return null;
  }
}
