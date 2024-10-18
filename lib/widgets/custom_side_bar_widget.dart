import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/modules/MainLayout/main_layout.dart';
import 'package:masrof/utilites/extensions.dart';

// ignore: must_be_immutable
class CustomNavigationRail extends StatefulWidget {
  int currentIndex;
  CustomNavigationRail({
    super.key,
    required this.currentIndex,
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
        selectedIconTheme:
            IconThemeData(color: ColorsPalette.of(context).primaryColor),
        selectedLabelTextStyle: TextStyleHelper.of(context)
            .bodyLarge16R
            .copyWith(color: ColorsPalette.of(context).primaryColor),
        unselectedLabelTextStyle: TextStyleHelper.of(context)
            .bodyMedium14R
            .copyWith(color: ColorsPalette.of(context).dividerColor),
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
        minWidth: 80,
        minExtendedWidth: 120,
        unselectedIconTheme:
            IconThemeData(color: ColorsPalette.of(context).primaryColor),
        extended: isExpanded,
        elevation: 2,
        onDestinationSelected: (_) {
          setState(() {
            currentIndex = _;
          });
          context.goNamed(menuList[currentIndex].route);
        },
        destinations: menuList
            .map((e) => NavigationRailDestination(
                selectedIcon: SvgPicture.asset(
                  e.imgSvg,
                  height: 24.h,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    ColorsPalette.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                icon: SvgPicture.asset(
                  e.imgSvg,
                  height: 24.h,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    ColorsPalette.of(context).dividerColor,
                    BlendMode.srcIn,
                  ),
                ),
                indicatorColor: ColorsPalette.of(context).primaryColor,
                label: Text(e.title)))
            .toList(),
        selectedIndex: currentIndex,
      ),
    );
  }
}
