import 'package:flutter/material.dart';
import 'package:state_extended/state_extended.dart';

class LoginController extends StateXController {
  ///singleTone
  LoginController._();
  static final LoginController _instance = LoginController._();
  factory LoginController() => _instance;
  late TextEditingController emailController, passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool loading = false;
  Future<void> login() async {
    if (formKey.currentState!.validate()) {}
  }
}
