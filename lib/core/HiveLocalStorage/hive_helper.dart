import 'package:hive_flutter/hive_flutter.dart';
import 'package:masrof/core/HiveLocalStorage/hive_constants.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter().then((_) async {
      await Future.wait([
        Hive.openBox(HiveConstants.dashboardKey),
        Hive.openBox(HiveConstants.expensesKey),
        Hive.openBox(HiveConstants.categoriesKey),
        Hive.openBox(HiveConstants.incomeKey),
        Hive.openBox(HiveConstants.profileKey),
        Hive.openBox(HiveConstants.settingsKey),
      ]);
    });
  }

}
