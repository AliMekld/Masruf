import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:state_extended/state_extended.dart';

class LoginController extends StateXController {
  ///singleTone
  LoginController._();
  static final LoginController _instance = LoginController._();
  factory LoginController() => _instance;
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController();
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

  // @override
  // dispose() {
  //   super.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  // }

  String authMessage = '';
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  bool loading = false;
  Future<void> login(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        final creadential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        if (creadential.user?.email != null) {
          log(creadential.user?.email?.toString() ?? "no email");
        }
        if (context.mounted) {
          context.goNamed(HomeScreen.routerName);
        }
      } catch (e, stacktrace) {
        log("${e.toString()} stacktrace $stacktrace");
        authMessage = e.toString();
        if (context.mounted) {
          DialogHelper.error(
            message: authMessage,
          ).showDialog(context);
        }
      }
    }
  }

  /// [register]
  Future<void> register(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // log("From Success ${credential.user?.email} ");
      } catch (e) {
        log("From TypeError ");
        // authMessage = e;
        // log(authMessage);\
        if (context.mounted) {
          DialogHelper.error(
            message: "Type Error:  ${e.toString()}",
          ).showDialog(context);
        }
      }
    }
  }
}
