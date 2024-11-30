import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:masrof/utilites/git_it.dart';

import '../core/theme/theme_model.dart';

// ignore: unused_import
import '../core/Language/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  /// Make this prefs as Locator
  static SharedPreferences get prefs => GitIt.instance.get<SharedPreferences>();

  ///=======================>  K E Y S  <=================================//
  static const String _languageCode = "language_code";
  static const String _appTheme = "appTheme";
  static const String _isFirstTimeOpenApp = "isFirstTimeOpenApp";
  static const String _isLogin = "isLogin";

  ///=====================> M E T H O D S <=================================//
  ///SET LANGUAGE
  static Future<void> setLanguage({required String lan}) async {
    await prefs.setString(_languageCode, lan);
  }

  ///GET LANGUAGE
  static Future<String?> getLanguage() async => prefs.getString(_languageCode) ?? "";

  ///SET THEME
  static Future<void> setTheme({required ThemeModel theme}) async {
    await prefs.setString(_appTheme, jsonEncode(theme));
  }

  ///GET THEME
  static Future<ThemeModel>? getTheme() async {
    Map<String, dynamic> json = await jsonDecode(prefs.getString(_appTheme) ?? "");
    return ThemeModel.fromJson(json);
  }

  /// SET IS FIRST TIME OPEN APP
  static Future<void> setIsFistTimeOpenApp({required bool value}) async {
    await prefs.setBool(_isFirstTimeOpenApp, value);
  }

  /// GET IS FIRST TIME OPEN APP
  static Future<bool?> getIsFistTimeOpenApp() async {
    debugPrint("_isFirstTimeOpenApp ${prefs.getBool(_isFirstTimeOpenApp) ?? true}");
    return prefs.getBool(_isFirstTimeOpenApp) ?? true;
  }

  /// SET IS LOGIN
  static Future<void> setIsLogin({required bool value}) async {
    await prefs.setBool(_isLogin, value);
  }

  /// SET IS LOGIN
  static Future<void> removeLoginData() async {
    await prefs.remove(_isLogin);
  }

  /// GET IS LOGIN
  static Future<bool?> getIsLogin() async {
    return prefs.getBool(_isLogin) ?? false;
  }



  void clearData() {
    prefs.clear();
  }
}