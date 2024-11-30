import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/Language/language_provider.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/theme_provider.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/gen/assets.gen.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/modules/Profile/profile_screen.dart';
import 'package:masrof/modules/Wallet/wallet_screen.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/constants/constamts.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/Dialogs/settings_dialog.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:masrof/widgets/custom_side_bar_widget.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  final String routeName;
  final Widget child;
  const MainLayout({
    super.key,
    required this.routeName,
    required this.child,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

int currentIndex = 0;

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.appName);
    return Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, theme, lang, w) {
      return Scaffold(
        appBar: context.isMobile
            ? AppBar(
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 28.r,
                    ),
                    onPressed: () {
                      const DialogHelper.customDialog(child: SettingsDialog())
                          .showDialog(context);
                    },
                  )
                ],
              )
            : null,
        backgroundColor:
            !context.isMobile ? ColorsPalette.of(context).primaryColor : null,
        body: context.isMobile
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.child,
              )
            : Row(
                children: [
                  CustomNavigationRail(
                    currentIndex: currentIndex,
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    // width: 1.sw,
                    // height: 1.sh-16,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          spreadRadius: 1.5,
                          blurStyle: BlurStyle.normal,
                          color: ColorsPalette.of(context).primaryColor,
                        )
                      ],
                      borderRadius: Constants.kBorderRaduis8,
                      color: ColorsPalette.of(context).backgroundColor,
                    ),
                    child: widget.child.expand,
                  ).expand
                ],
              ),
        floatingActionButtonLocation:
            context.isMobile ? FloatingActionButtonLocation.centerDocked : null,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: context.isMobile
            ? BottomNavigationBar(
                elevation: 0.5,
                backgroundColor: ColorsPalette.of(context).primaryColor,
                currentIndex: currentIndex,
                selectedItemColor: ColorsPalette.of(context).primaryTextColor,
                unselectedItemColor:
                    ColorsPalette.of(context).secondaryTextColor,
                unselectedLabelStyle: TextStyleHelper.of(context)
                    .bodySmall12R
                    .copyWith(color: ColorsPalette.of(context).iconColor),
                selectedLabelStyle: TextStyleHelper.of(context)
                    .bodyMedium14R
                    .copyWith(color: ColorsPalette.of(context).backgroundColor),
                onTap: (_) {
                  setState(() {
                    // ignore: no_wildcard_variable_uses
                    currentIndex = _;
                  });
                  context.goNamed(menuList[currentIndex].route);
                },
                items: [
                  ...menuList.map(
                    (e) => BottomNavigationBarItem(
                      backgroundColor: ColorsPalette.of(context).buttonColor,
                      icon: SvgPicture.asset(
                        e.imgSvg,
                        height: 24.h,
                        width: 24.w,
                        colorFilter: ColorFilter.mode(
                          ColorsPalette.of(context).iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: e.title.tr,
                    ),
                  ),
                ],
              )
            : null,
      );
    });
  }
}

List<MenuModel> get menuList => _menuList;
List<MenuModel> _menuList = [
  MenuModel(
    index: 0,
    title:Strings.home,
    imgSvg: Assets.images.home,
    route: HomeScreen.routerName,
  ),
  MenuModel(
    index: 1,
    title: Strings.wallet,
    imgSvg: Assets.images.messages,
    route: WalletScreen.routerName,
  ),
  MenuModel(
    index: 2,
    title: Strings.profile,
    imgSvg: Assets.images.profile,
    route: ProfileScreen.routerName,
  ),
];

class MenuModel {
  final int index;
  final String route;
  final String title;
  final String imgSvg;

  MenuModel(
      {required this.index,
      required this.route,
      required this.title,
      required this.imgSvg});
}
