import 'package:flutter/material.dart';
import 'package:state_extended/state_extended.dart';

class LoginController extends StateXController {
  ///singleTone
  LoginController._();
  static final LoginController _instance = LoginController._();
  factory LoginController() => _instance;
  late TextEditingController searchController;

  @override
  initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
  }

  bool loading = false;
}
