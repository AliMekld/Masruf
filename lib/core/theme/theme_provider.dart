import 'package:flutter/material.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/theme_model.dart';
import 'package:masrof/utilities/shared_pref.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel get appTheme => _appTheme;
  SystemBrightness? brightness;
  static ThemeModel _appTheme = ThemeModel.defultTheme;

  static ThemeData get _darkTheme => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(extensions: <ThemeExtension<ThemeModel>>[_appTheme]);
  static ThemeData get _lightTheme => ThemeData.light(
        useMaterial3: true,
      ).copyWith(extensions: <ThemeExtension<ThemeModel>>[_appTheme]);

  ThemeData themeData = _appTheme.isDark ? _darkTheme : _lightTheme;
  void fetchTheme() {
    _appTheme = SharedPref.getTheme() ?? ThemeModel.defultTheme;
    // notifyListeners();
  }

  void changeTheme(SystemBrightness brightness) {
    switch (brightness) {
      case SystemBrightness.dark:
        _appTheme = ColorsPalette.dark();
        this.brightness = brightness;
        notifyListeners();
        break;
      case SystemBrightness.light:
        _appTheme = ColorsPalette.light();
        this.brightness = brightness;
        notifyListeners();
        break;
    }
    debugPrint(_appTheme.toJson().toString());
    SharedPref.setTheme(theme: _appTheme);
  }
}

enum SystemBrightness {
  light,
  dark,
}
