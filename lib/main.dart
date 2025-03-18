/// todo :
/// step 1- intializing app with its configurations this configutation can be used for other projects if it done will
/// 1-core
///   1-theming
///     1-color_palette[done]
///     2-theme_provier[done]
///     3-theme_model[done]
///   2-localization[done]
//
///   3-api
///     1-generic request
///     2-api methods
///
///
///   4-local storage
///     1-crud manger[done ]
///     2-sqflite_hlper[done]
///     3-sql_queries[done]
/// ============================================================================================///
/// 2-utilties
///   1-helpers
///     1-file_download_helper
///     2-
///
///   2-git_locator
///   3-isolates ?????????
///     1-study event loop
///     2-how isolates communicate with eventloop
///     3-
///   4-router configuration
///
///   5-constants
///     1-Strings[done]
///     2-enums[done]
///     3-constants[done]
///     4-mixins[done]
///   6-generic table data[done]
/// step 2- creating design with its modules and models
/// step 3 integrating with api if needed
/// step 4 integrating with local database to store large amount of data[done]
///FIREBASE CONFIGURATION [DONE]
///GIT_IT CONFIGURATION [DONE]
///DATABASE_HELPER [DONE]
///PDF_HELPER [DONE]
///RESPONSIVE_DESIGN [DONE]
///THEME_PROVIDER [DONE]
///LOCALIZATION [DONE]
///ROUTER [DONE]
///SCREEN_UTIL [DONE]
///LOCAL_DATABASE [DONE]
///SHARED_PREFERENCES [DONE]
///TODO :: FIREBASE_CLOUD_MESSAGING [-]
///TODO :: FIREBASE_AUTHENTICATION [-]
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/Language/language_provider.dart';
import 'package:masrof/core/LocalDataBase/database_helper.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/theme_provider.dart';
import 'package:masrof/utilites/git_it.dart';
import 'package:masrof/utilites/router_config.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/Language/app_localization.dart';

const Size mobileSize = Size(375, 812);
const Size tabletSize = Size(768, 1024);
const Size desktopSize = Size(1440, 900);
const Size fullHdDesktopSize = Size(1920, 1080);

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// [initialize_firebase]
  if (defaultTargetPlatform != TargetPlatform.linux) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  /// [initialize_git_it]
  await GitIt.initGitIt();

  /// [initialize_pdf]
  // await PDFConfig.loadFont();

  if (!kIsWeb) {
    /// [initialize_database_helper]
    await DatabaseHelper().initDataBase();
  }
  if (kIsWeb) {
    usePathUrlStrategy();
  }

  runApp(
    MultiProvider(
      providers: [
        /// [initialize_providers]
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: const EntryPoint(),
    ),
  );
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);

    /// Fetching the theme and
    /// language from the local storage [SHARED_PREFERENCES]
    lang.fetchLocale();
    theme.fetchTheme();

    return LayoutBuilder(builder: (context, constaints) {
      /// [RESPONSIVE_DESIGN_CONFIGURATION]
      Size appSize = const Size(375, 812);
      if (constaints.maxWidth >= 1024) {
        if (constaints.maxWidth > 1440) {
          appSize = fullHdDesktopSize;
        } else {
          appSize = desktopSize;
        }
      } else if (constaints.maxWidth >= 600) {
        appSize = tabletSize;
      } else {
        appSize = mobileSize;
      }
      return ScreenUtilInit(
        ///TEXT_SCALING [ENABLED]
        enableScaleText: () => true,

        designSize: appSize,
        child: MaterialApp.router(
          
          /// [initialize_router]
          routerConfig: router,

          ///[PASSING_THEME]
          theme: theme.themeData.copyWith(
              cardColor: ColorsPalette.of(context).secondaryColor,
              scaffoldBackgroundColor:
                  ColorsPalette.of(context).backgroundColor,
              dialogBackgroundColor: ColorsPalette.of(context).backgroundColor),

          ///[OTHER_CONFIGURATION]
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),

          ///[MULTI_LANGUAGE_CONFIGURATION]
          supportedLocales: Languages.values.map((e) => Locale(e.name)),
          locale: lang.appLang,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );
    });
  }
}

/// Enable scrolling with mouse dragging
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
