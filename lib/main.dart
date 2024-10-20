/// todo :
/// step 1- intializing app with its configurations this configutation can be used for other projects if it done will
/// 1-core
///   1-theming
///     1-color_palette[done]
///     2-theme_provier[done]
///     3-theme_model[done]
///   2-localization
//
///   3-api
///     1-generic request
///     2-api methods
///
///
///   4-local storage
///     1-crud manger
///     2-sqflite_hlper
///     3-sql_queries
/// ============================================================================================///
/// 2-utilties
///   1-helpers
///     1-file_download_helper
///     2-
///
///   2-git_locator
///
///   3-isolates ?????????
///     1-study event loop
///     2-how isolates communicate with eventloop
///     3-
///
///   4-router configuration
///
///   5-constants
///     1-Strings
///     2-enums
///     3-constants
///     4-mixins
///   6-generic table data
/// step 2- creating design with its modules and models
/// step 3 integrating with api if needed
/// step 4 integrating with local database to store large amount of data
///
///
// ignore_for_file: depend_on_referenced_packages

library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/theme_provider.dart';
import 'package:masrof/utilites/router_config.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

const Size mobileSize = Size(375, 812); // iPhone X size
const Size tabletSize = Size(768, 1024); // iPad size
const Size desktopSize = Size(1440, 900); // MacBook Pro size
const Size fullHdDesktopSize = Size(1920, 1080);

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
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
    return LayoutBuilder(builder: (context, constaints) {
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
        enableScaleText: () => true,
  
        designSize: appSize,
        child: MaterialApp.router(
          theme: theme.themeData.copyWith(
            scaffoldBackgroundColor: ColorsPalette.of(context).backgroundColor,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      );
    });
  }
}
