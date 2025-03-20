class Validator {
  static validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is empty';
    }
    if (!email.contains('@')) {
      'Email is invalid';
    } else {
      return null;
    }
  }

  static validatePassword(String? password) {
    if (password?.isEmpty ?? false) {
      return 'Password is empty';
    }
    if ((password?.length ?? 0) < 6) {
      return 'Password is too short';
    } else {
      return null;
    }
  }
}
