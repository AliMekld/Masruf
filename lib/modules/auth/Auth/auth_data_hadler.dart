import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDataHadler {
  static Future<Either<Exception, void>> login(
      String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return right(null);
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }

  static Future<Either<Exception, void>> signUp(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return right(null);
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }
}
