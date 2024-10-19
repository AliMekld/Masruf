import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/theme_provider.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/gen/assets.gen.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/modules/Profile/profile_screen.dart';
import 'package:masrof/modules/Wallet/wallet_screen.dart';
import 'package:masrof/utilites/constants/constamts.dart';
import 'package:masrof/utilites/extensions.dart';
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
    return Consumer<ThemeProvider>(builder: (context, theme, w) {
      return Scaffold(
        backgroundColor: ColorsPalette.of(context).primaryColor,
        body: context.isMobile
            ? Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.5,
                      spreadRadius: 1.5,
                      blurStyle: BlurStyle.outer,
                      color: ColorsPalette.of(context).iconColor,
                    )
                  ],
                  borderRadius: Constants.kBorderRaduis8,
                  color: ColorsPalette.of(context).backgroundColor,
                ),
                child: widget.child,
              )
            : Row(
                children: [
                  CustomNavigationRail(
                    currentIndex: currentIndex,
                  ),
                  Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          spreadRadius: 1.5,
                          blurStyle: BlurStyle.outer,
                          color: ColorsPalette.of(context).primaryColor,
                        )
                      ],
                      borderRadius: Constants.kBorderRaduis8,
                      color: ColorsPalette.of(context).backgroundColor,
                    ),
                    child: widget.child,
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
                backgroundColor:
                    ColorsPalette.of(context).primaryColor.withOpacity(0.5),
                currentIndex: currentIndex,
                unselectedLabelStyle: TextStyleHelper.of(context)
                    .bodySmall12R
                    .copyWith(color: ColorsPalette.of(context).backgroundColor),
                selectedLabelStyle: TextStyleHelper.of(context)
                    .bodyMedium14R
                    .copyWith(color: ColorsPalette.of(context).backgroundColor),
                onTap: (_) {
                  setState(() {
                    currentIndex = _;
                  });
                  context.goNamed(menuList[currentIndex].route);
                },
                items: [
                  ...menuList.map(
                    (e) => BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        e.imgSvg,
                        height: 24.h,
                        width: 24.w,
                        colorFilter: ColorFilter.mode(
                          widget.routeName.contains(e.route)
                              ? ColorsPalette.of(context).primaryColor
                              : ColorsPalette.of(context).dividerColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: e.title,
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
  ///TODO :FIX ASSETS GENERATING LOGIC
  MenuModel(
    index: 0,
    title: 'Home',
    imgSvg: Assets.images.home,
    route: HomeScreen.routerName,
  ),
  MenuModel(
    index: 1,
    title: 'Wallet',
    imgSvg: Assets.images.messages,
    route: WalletScreen.routerName,
  ),
  MenuModel(
    index: 2,
    title: 'Profile',
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
