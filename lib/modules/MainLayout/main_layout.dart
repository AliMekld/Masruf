import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/gen/assets.gen.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/modules/Profile/profile_screen.dart';
import 'package:masrof/modules/Wallet/wallet_screen.dart';
import 'package:masrof/utilites/extensions.dart';

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
    return Scaffold(
      body: context.isMobile
          ? widget.child
          : Row(
              children: [
                CustomNavigationRail(
                  onSelectItem: (_) {
                    setState(() {
                      currentIndex = _;
                    });
                    context.goNamed(_menuList[currentIndex].route);
                  },
                  currentIndex: 0,
                ),
                widget.child.expand
              ],
            ),
      bottomNavigationBar: context.isMobile
          ? BottomNavigationBar(
              onTap: (_) {
                setState(() {
                  currentIndex = _;
                });
                context.goNamed(_menuList[currentIndex].route);
              },
              items: [
                  ..._menuList
                      .map((e) => BottomNavigationBarItem(
                            backgroundColor: Colors.red,
                            icon: SvgPicture.asset(
                              e.imgSvg,
                              height: 24.h,
                              width: 24.w,
                            ),
                            label: e.title,
                          ))
                      .toList()
                ])
          : null,
    );
  }
}

class CustomNavigationRail extends StatefulWidget {
  final int currentIndex;
  final Function(int) onSelectItem;
  const CustomNavigationRail({
    super.key,
    required this.currentIndex,
    required this.onSelectItem,
  });

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: NavigationRail(
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                icon: Icon(
                  isExpanded
                      ? Icons.arrow_back_ios_new
                      : Icons.arrow_forward_ios_outlined,
                ),
              ),
              16.h.heightBox,
            ],
          ).expand,
      
          minExtendedWidth: 80,
          extended: isExpanded,
          elevation: 20,
          onDestinationSelected: widget.onSelectItem,
          destinations: _menuList
              .map((e) => NavigationRailDestination(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  icon: SvgPicture.asset(
                    e.imgSvg,
                    height: 24.h,
                    width: 24.w,
                  ),
                  label: Text(
                    e.title,
                    style: TextStyle(fontSize: 16),
                  )))
              .toList(),
          selectedIndex: widget.currentIndex),
    );
  }
}

List<MenuModel> _menuList = [
  MenuModel(
    title: 'Home',
    imgSvg: Assets.images.appLogo,
    route: HomeScreen.routerName,
  ),
  MenuModel(
    title: 'Wallet',
    imgSvg: Assets.images.appLogo,
    route: WalletScreen.routerName,
  ),
  MenuModel(
    title: 'Profile',
    imgSvg: Assets.images.appLogo,
    route: ProfileScreen.routerName,
  ),
];

class MenuModel {
  final String route;
  final String title;
  final String imgSvg;

  MenuModel({required this.route, required this.title, required this.imgSvg});
}
