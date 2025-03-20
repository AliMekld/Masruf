import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/Language/language_provider.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/theme_provider.dart';
import 'package:masrof/modules/auth/login/login_controller.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/constants/assets.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/utilites/validator.dart';
import 'package:masrof/widgets/custom_text_field_widget.dart';
import 'package:masrof/widgets/cutom_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:state_extended/state_extended.dart';

import '../../../core/theme/typography.dart';

class LoginScreen extends StatefulWidget {
  static const String routerName = 'loginScreen';
  const LoginScreen({super.key});

  @override
  StateX<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends StateX<LoginScreen> {
  _LoginScreenState() : super(controller: LoginController()) {
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
                flex: 4,
                child: Form(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 24.h,
                      children: [
                        SvgPicture.asset(
                          Assets.imagesAppLogo,
                          width: 120.r,
                          height: 120.r,
                        ),
                        // Text(
                        //   Strings.appName.tr,
                        //   style: TextStyleHelper.of(context)
                        //       .headlinelarge32R
                        //       .copyWith(
                        //         color: ColorsPalette.of(context).successColor,
                        //       ),
                        // ),
                        Text(
                          Strings.welcomeBack.tr,
                          style: TextStyleHelper.of(context)
                              .headlinelarge32R
                              .copyWith(
                                color: ColorsPalette.of(context).buttonColor,
                              ),
                        ),
                        Text(
                          Strings.login.tr,
                          style: TextStyleHelper.of(context).headlineSmall24R,
                        ),
                        CustomTextFieldWidget(
                          textInputType: TextInputType.emailAddress,
                          validator: (v) => Validator.validateEmail(v!),
                          lableText: Strings.email.tr,
                          controller: con.emailController,
                        ),
                        CustomTextFieldWidget(
                          textInputType: TextInputType.visiblePassword,
                          validator: (v) => Validator.validatePassword(v!),
                          lableText: Strings.password.tr,
                          controller: con.passwordController,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(Strings.forgetPassword.tr,
                              style: TextStyleHelper.of(context).bodySmall12R),
                        ),
                        CustomButtonWidget.primary(
                          width: 320.w,
                          context: context,
                          onTap: () async => await con.login(),
                          buttonTitle: Strings.login.tr,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Divider(
                              color: ColorsPalette.of(context).primaryTextColor,
                              thickness: 0.2,
                              height: 0,
                            ).expand,
                            Text(Strings.or.tr,
                                style: TextStyleHelper.of(context)
                                    .bodyMedium14R
                                    .copyWith(
                                      color: ColorsPalette.of(context)
                                          .primaryTextColor,
                                    )).addPaddingHorizontal(padding: 4),
                            Divider(
                              color: ColorsPalette.of(context).primaryTextColor,
                              thickness: 0.2,
                              height: 0,
                            ).expand,
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.facebook,
                                  size: 32.r,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.g_translate,
                                  size: 32.r,
                                )),
                          ],
                        ).widthBox(200),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Strings.dontHaveAccount.tr,
                                style: TextStyleHelper.of(context)
                                    .bodyMedium14R
                                    .copyWith(
                                      color: ColorsPalette.of(context)
                                          .primaryTextColor,
                                    )),
                            TextButton(
                              onPressed: () {},
                              child: Text(Strings.registerNow.tr,
                                  style: TextStyleHelper.of(context)
                                      .bodyMedium14R),
                            ),
                          ],
                        ),
                      ],
                    ).withVerticalScroll,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
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
                          spacing: 8,
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (isArabic(context)) {
                                  await languageProvider.changeLanguage(
                                      language: const Locale("en"));
                                  setState(() {});
                                } else {
                                  await languageProvider.changeLanguage(
                                      language: const Locale("ar"));
                                  setState(() {});
                                }
                              },
                              icon: const Icon(Icons.language),
                            ),
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
