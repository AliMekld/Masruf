import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/HiveLocalStorage/hive_helper.dart';
import 'package:masrof/core/Language/language_provider.dart';
import 'package:masrof/core/LocalDataBase/database_helper.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/theme_provider.dart';
import 'package:masrof/utilities/git_it.dart';
import 'package:masrof/utilities/router_config.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:masrof/widgets/app_settings_loader.dart';
import 'package:provider/provider.dart';
import 'core/Language/app_localization.dart';
import 'utilities/PDFHelper/pdf_widgets.dart';

const Size mobileSize = Size(375, 812);
const Size tabletSize = Size(768, 1024);
const Size desktopSize = Size(1440, 900);
const Size fullHdDesktopSize = Size(1920, 1024);
/// todo replace state mange management by bloc
/// todo fix this error  TooltipState is a SingleTickerProviderStateMixin but multiple tickers were created.
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();

  /// [initialize_firebase]
  // try {
  //   if (!isWindowsApp()) {
  //     await Firebase.initializeApp(
  //         options: DefaultFirebaseOptions.currentPlatform);
  //   }
  //   log("success in Firebase Initialization:");
  // } on FirebaseException catch (e) {
  //   log("Error in Firebase Initialization: $e");
  // }
  await AppSettingsLoader.load();

  /// [initialize_git_it]
  await GitIt.initGitIt();

  /// [initialize_pdf]
  await PDFConfig.loadFont();

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
      Size? appSize;
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
        designSize: appSize,
        child: MaterialApp.router(
          /// [initialize_router]
          routerConfig: router,

          ///[PASSING_THEME]
          theme: theme.themeData.copyWith(
              cardColor: ColorsPalette.of(context).secondaryColor,
              scaffoldBackgroundColor:
                  ColorsPalette.of(context).backgroundColor,
              /*dialogBackgroundColor: ColorsPalette.of(context).backgroundColor*/),

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
        PointerDeviceKind.trackpad,
      };
}
