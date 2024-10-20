import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/modules/MainLayout/main_layout.dart';
import 'package:masrof/utilites/constants/constamts.dart';
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
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(

      leading: SizedBox(
        height: 60,
        child: Text(
          "MASRUF",
          style: TextStyleHelper.of(context).bodyLarge16R.copyWith(
              fontSize: isExpanded ? 24 : 12,
              fontFamily: Constants.agbalumoFontFamily,
              color: Colors.white),
        ).center.addPaddingAll(padding: 4),
      ),
      backgroundColor: ColorsPalette.of(context).primaryColor,
      selectedIconTheme:
          IconThemeData(color: ColorsPalette.of(context).backgroundColor),
      selectedLabelTextStyle: TextStyleHelper.of(context)
          .bodyLarge16R
          .copyWith(color: ColorsPalette.of(context).backgroundColor),
      unselectedLabelTextStyle: TextStyleHelper.of(context)
          .bodyMedium14R
          .copyWith(color: ColorsPalette.of(context).backgroundColor),
     
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
              Icons.settings,
              size: 28,
              color: ColorsPalette.of(context).iconColor,
            ),
          ),
          24.h.heightBox,
          IconButton(
            onPressed: () {
              setState(
                () {
                  isExpanded = !isExpanded;
                },
              );
            },
            icon: Icon(
              isExpanded
                  ? Icons.arrow_back_ios_new
                  : Icons.arrow_forward_ios_outlined,
              color: ColorsPalette.of(context).iconColor,
            ),
          ),
          16.h.heightBox,
        ],
      ).expand,
      minWidth: 48,
      minExtendedWidth: 116,
      unselectedIconTheme:
          IconThemeData(color: ColorsPalette.of(context).iconColor),
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
                    ColorsPalette.of(context).buttonDisabledColor,
                    BlendMode.srcIn,
                  ),
                ),
                // padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                icon: SvgPicture.asset(
                  e.imgSvg,
                  height: 24.h,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    ColorsPalette.of(context).backgroundColor.withOpacity(0.5),
                    BlendMode.srcIn,
                  ),
                ),
                // indicatorColor: ColorsPalette.of(context).primaryColor,
                label: Text(e.title),
              ))
          .toList(),
      selectedIndex: currentIndex,
      // extended:isExpanded,
      labelType: NavigationRailLabelType.selected,
    );
  }
}
