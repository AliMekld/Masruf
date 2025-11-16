import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/Language/app_localization.dart';
import '../widgets/login_part.dart';
import '../widgets/register_part.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/extensions.dart';
import 'package:provider/provider.dart';
import 'package:state_extended/state_extended.dart';

import '../../../../core/Language/language_provider.dart';
import '../../../../core/theme/color_pallete.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/typography.dart';
import '../../../../utilities/constants/Strings.dart';
import '../auth_controller.dart';

class MeduimAuthScreen extends StatefulWidget {
  const MeduimAuthScreen({super.key});

  @override
  StateX<MeduimAuthScreen> createState() => _MeduimAuthScreenState();
}

class _MeduimAuthScreenState extends StateX<MeduimAuthScreen> {
  _MeduimAuthScreenState() : super(controller: LoginController()) {
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
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Form(
                  key: con.formKey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsPalette.of(context)
                          .secondaryColor
              .withValues(alpha:0.2),
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          color: ColorsPalette.of(context)
                              .secondaryTextColor
                              .withValues(alpha:0.4),
                          spreadRadius: 4,
                          blurRadius: 4,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.all(24),
                    child: Column(children: [
                      SvgPicture.asset(
                        Assets.imagesAppLogo,
                        width: 120.r,
                        height: 120.r,
                      ),
                      18.h.heightBox,
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
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesLoginBackground),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                        end: 20,
                        top: 20,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (isArabic(context)) {
                                  await languageProvider.changeLanguage(
                                      language: const Locale('en'));
                                } else {
                                  await languageProvider.changeLanguage(
                                      language: const Locale('ar'));
                                }
                              },
                              icon: const Icon(Icons.language),
                            ),
                            8.w.widthBox,
                            Text(
                              Strings.language.tr,
                              style: TextStyleHelper.of(context).bodyMedium14R,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ));
    });
  }
}
