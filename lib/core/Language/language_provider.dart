// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:masrof/utilities/shared_pref.dart';
import 'package:provider/provider.dart';

///-> Languages Enum
enum Languages { en, ar }

///-> Boolean To Detect Is App Arabic
Locale appLan(BuildContext context) =>
    Provider.of<LanguageProvider>(context).appLang;

class LanguageProvider extends ChangeNotifier {
  ///-> THIS VARIABLE HAVE THE VALUE OF LANGUAGE
  ///-> INITIAL VALUE =>ARABIC
  Locale _appLanguage = Locale(Languages.en.name);

  ///-> GETTER TO GET THIS PRIVATE VARIABLE
  Locale get appLang => _appLanguage;

  ///-> FETCH LOCAL
  ///-> 1 FROM DEVICE IF NULL ?? FROM INITIAL VALUE [Languages.ar]
  fetchLocale() {
    String sharedLocal = SharedPref.getLanguage() ?? "";

    ///-> CHECK IF SHARED PREFS HASN'T A LANG VALUE
    if (sharedLocal.isEmpty) {
      //Fetch From Device First
      _appLanguage = const Locale("ar");
    } else {
      _appLanguage = Locale(sharedLocal);
    }
    // notifyListeners();
  }

  Future changeLanguage({Locale? language}) async {
    if (language == _appLanguage) return;
    if (language == Locale(Languages.en.name)) {
      _appLanguage = Locale(Languages.en.name);
    } else if (language?.languageCode == Languages.ar.name) {
      _appLanguage = Locale(Languages.ar.name);
    } else {
      _appLanguage = _appLanguage == Locale(Languages.ar.name)
          ? Locale(Languages.en.name)
          : Locale(Languages.ar.name);
    }
    await SharedPref.setLanguage(lan: _appLanguage.languageCode);
    notifyListeners();
  }
}
