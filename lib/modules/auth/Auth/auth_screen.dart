import 'package:flutter/material.dart';
import 'auth_controller.dart';
import 'package:state_extended/state_extended.dart';
import '../../../core/responsive_builder.dart';
import 'screen_layouts/l_auth_screen.dart';
import 'screen_layouts/m_auth_screen.dart';
import 'screen_layouts/s_auth_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String routerName = 'authScreen';
  const AuthScreen({super.key});

  @override
  StateX<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends StateX<AuthScreen>
    with ResponsiveStatufullBuilder {
  _AuthScreenState() : super(controller: LoginController()) {
    con = LoginController();
  }
  @override
  initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {}
    });
  }

  late LoginController con;

  @override
  Widget buildDesktop(BuildContext context) {
    return const LargAuthScreen();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return const SmallAuthScreen();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return const MeduimAuthScreen();
  }
}
