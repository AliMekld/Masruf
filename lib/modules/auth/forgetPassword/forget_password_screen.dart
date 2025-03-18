import 'package:flutter/material.dart';
import 'package:masrof/utilites/extensions.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routerName = 'forgetPassword';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Profile").center,
    );
  }
}
