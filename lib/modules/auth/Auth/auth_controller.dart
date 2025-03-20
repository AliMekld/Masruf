import 'package:flutter/material.dart';
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

  bool loading = false;
  Future<void> login() async {
    if (formKey.currentState!.validate()) {}
  }
}
