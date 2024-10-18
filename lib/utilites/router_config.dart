import 'package:go_router/go_router.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/modules/MainLayout/main_layout.dart';
import 'package:masrof/modules/Splash/splash_screen.dart';

final GoRouter _router = GoRouter(
  routes: [
    ///==============>> [Splash]
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    ///==============>> [onBoarding]
    ///todo

    ///==============>> [ShellRoute]
    ShellRoute(
      redirect: (context, state) {},
      builder: (context, state, child) {
        return MainLayout(routeName: state.fullPath!, child: child);
      },
      routes: [
        ///==============>> [Home]
        GoRoute(
          path: "/${HomeScreen.routerName}",
          name: HomeScreen.routerName,
          builder: (context, state) => const SplashScreen(),
        ),
      ],
    )
  ],
);
GoRouter get router => _router;
///todo create custom transation 
