import 'package:flutter/cupertino.dart';
import 'package:masrof/core/theme/theme_model.dart';
import 'package:masrof/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ColorsPalette extends ThemeModel {
  /// inherted widget to get currnet app theme based on brightness
  static ThemeModel of(BuildContext context) =>
      Provider.of<ThemeProvider>(context).appTheme;

  ///==============================>>[dark_palette]<<=================================///
  ColorsPalette.dark({
    super.isDark = true,
    super.primaryColor = const Color(0xff0760FB),
    super.secondaryColor = const Color(0xff6C8BC2),
    super.backgroundColor = const Color(0xff303D4D),
    super.surfaceColor = const Color(0xff363535),
    super.primaryTextColor = const Color(0xffF3F7FF),
    super.secondaryTextColor = const Color(0xffA0A0A0),
    super.errorColor = const Color(0xffD81515),
    super.buttonColor = const Color(0xff0760FB),
    super.buttonDisabledColor = const Color(0xff3E3E3E),
    super.dividerColor = const Color(0xff2B2B2B),
    super.iconColor = const Color(0xffA0A0A0),
    super.successColor = const Color(0xff27A745),
    super.watingColor = const Color(0xffFCED25),
  });

  ///==============================>>[dark_palette]<<=================================///
  ColorsPalette.light({
    super.isDark = false,
    super.primaryColor = const Color(0xff0760FB),
    super.secondaryColor = const Color(0xff6C8BC2),
    super.backgroundColor = const Color(0xffF4F6F8),
    super.surfaceColor = const Color(0xffFFFFFF),
    super.primaryTextColor = const Color(0xff000000),
    super.secondaryTextColor = const Color(0xff757575),
    super.errorColor = const Color(0xffD81515),
    super.buttonColor = const Color(0xff0760FB),
    super.buttonDisabledColor = const Color(0xffBDBDBD),
    super.dividerColor = const Color(0xffDCDDDF),
    super.iconColor = const Color(0xff757575),
    super.successColor = const Color(0xff27A745),
    super.watingColor = const Color(0xffFCED25),
  });
}
