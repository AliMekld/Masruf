import 'package:go_router/go_router.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/modules/MainLayout/main_layout.dart';
import 'package:masrof/modules/Profile/profile_screen.dart';
import 'package:masrof/modules/Splash/splash_screen.dart';
import 'package:masrof/modules/Wallet/wallet_screen.dart';

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
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: "/${WalletScreen.routerName}",
          name: WalletScreen.routerName,
          builder: (context, state) => const WalletScreen(),
        ),
        GoRoute(
          path: "/${ProfileScreen.routerName}",
          name: ProfileScreen.routerName,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    )
  ],
);
GoRouter get router => _router;
///todo create custom transation 
