import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrof/modules/auth/Auth/widgets/login_part.dart';
import 'package:masrof/modules/auth/Auth/widgets/register_part.dart';
import 'package:masrof/utilites/constants/assets.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:provider/provider.dart';
import 'package:state_extended/state_extended.dart';

import '../../../../core/Language/language_provider.dart';
import '../../../../core/theme/color_pallete.dart';
import '../../../../core/theme/theme_provider.dart';

import '../auth_controller.dart';

class SmallAuthScreen extends StatefulWidget {
  const SmallAuthScreen({super.key});

  @override
  StateX<SmallAuthScreen> createState() => _SmallAuthScreenState();
}

class _SmallAuthScreenState extends StateX<SmallAuthScreen> {
  _SmallAuthScreenState() : super(controller: LoginController()) {
    con = LoginController();
  }
  late LoginController con;
  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
        builder: (context, languageProvider, themeProvider, child) {
      return Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(
            color: ColorsPalette.of(context).backgroundColor,
          ),
          Form(
            key: con.formKey,
            child: Container(
              decoration: BoxDecoration(
                color: ColorsPalette.of(context)
                    .secondaryColor
                    .withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: ColorsPalette.of(context)
                        .secondaryTextColor
                        .withValues(alpha: 0.4),
                    spreadRadius: 4,
                    blurRadius: 4,
                  ),
                ],
                borderRadius: BorderRadius.circular(16.r),
              ),
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              child: Column(spacing: 18.h, children: [
                SvgPicture.asset(
                  Assets.imagesAppLogo,
                  width: 120.r,
                  height: 120.r,
                ),
                RepaintBoundary(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    child: con.isLogin
                        ? LoginPart(con: con, key: UniqueKey())
                        : RegiserPart(con: con, key: UniqueKey()),
                  ),
                ),
              ]).withVerticalScroll,
            ),
          ),
        ],
      ));
    });
  }
}
