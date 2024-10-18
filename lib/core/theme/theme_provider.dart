import 'package:flutter/material.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/theme_model.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeModel get appTheme => _appTheme;
  static ThemeModel _appTheme = ThemeModel.defultTheme;

  static ThemeData get _darkTheme => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(extensions: <ThemeExtension<ThemeModel>>[_appTheme]);
  static ThemeData get _lightTheme => ThemeData.light(
        useMaterial3: true,
      ).copyWith(extensions: <ThemeExtension<ThemeModel>>[_appTheme]);

  ThemeData themeData = _appTheme.isDark ? _darkTheme : _lightTheme;
  void changeTheme(SystemBrightness brightness) {
    switch (brightness) {
      case SystemBrightness.dark:
        _appTheme = ColorsPalette.dark();
      case SystemBrightness.light:
        _appTheme = ColorsPalette.light();
    }
    print(_appTheme.toJson());
    notifyListeners();
  }
}
enum SystemBrightness{
  light,dark,
}