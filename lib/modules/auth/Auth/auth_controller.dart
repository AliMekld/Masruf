import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:state_extended/state_extended.dart';

class LoginController extends StateXController {
  ///singleTone
  LoginController._();
  static final LoginController _instance = LoginController._();
  factory LoginController() => _instance;
  late TextEditingController emailController,
      passwordController,
      confirmPasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLogin = true;
  void toggleLogin() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void togglePasswordVisability() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisability() {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  @override
  initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  String authMessage = '';
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  bool loading = false;
  Future<void> login(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        final _auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        log("From Success ${_auth.user?.email} ");
        if (context.mounted) {
          context.goNamed(HomeScreen.routerName);
        }
      } catch (e) {
        authMessage = e.toString();
        log(authMessage);
      }
    }
  }

  /// [register]
  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        final _auth =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        log("From Success ${_auth.user?.email} ");
      } on FirebaseAuthException catch (e) {
        log("From FirebaseAuthException Error ${e.message} ");
      } on FirebaseException catch (e) {
        log("From FirebaseException Error ${e.message} ");
      } catch (e) {
        log("From TypeError ");
      }
    }
  }
}
