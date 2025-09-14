import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masrof/models/app_setting_model.dart';
import 'package:masrof/utilites/git_it.dart';

import '../utilites/constants/assets.dart';

class AppSettingsLoader {
  static Future<void> load() async {
    try {
      final appSettingsString = await rootBundle.loadString(Assets.appSettings);
      final Map<String, dynamic> decodedString = json.decode(appSettingsString);
      AppSettings appSettingsModel = AppSettings.fromJson(decodedString);
      GitIt.instance.registerSingleton<AppSettings>(appSettingsModel);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
