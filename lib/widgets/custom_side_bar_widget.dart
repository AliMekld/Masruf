import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/modules/MainLayout/main_layout.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/constants/constamts.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/utilites/shared_pref.dart';
import 'package:masrof/widgets/Dialogs/settings_dialog.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';

import '../utilites/constants/assets.dart';

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
  bool isExpanded = SharedPref.getIsSideBarExpanded();
  bool isSettingsExpanded = false;
  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.appName);
    return AnimatedContainer(
      decoration: BoxDecoration(
          color: ColorsPalette.of(context).backgroundColor,
          border: Border(
              left: isArabic(context)
                  ? BorderSide(
                      color: ColorsPalette.of(context).dividerColor,
                      width: 1,
                      style: BorderStyle.solid,
                    )
                  : BorderSide.none)),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      width: isExpanded ? 180.w : 80.w,
      // height: 1.sh,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          16.0.heightBox,
          CircleAvatar(
            radius: isExpanded ? 42 : 26,
            backgroundColor: ColorsPalette.of(context).dividerColor,
            child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: ColorsPalette.of(context).surfaceColor,
                // foregroundImage: const AssetImage(Assets.imagesHome),
                radius: isExpanded ? 40 : 24,
                child: SvgPicture.asset(
                  Assets.imagesProfile,
                  fit: BoxFit.cover,
                  width: isExpanded ? 48.w : 24.w,
                  height: isExpanded ? 48.h : 24.h,
                  colorFilter: ColorFilter.mode(
                    ColorsPalette.of(context).secondaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          16.0.heightBox,
          Text(
            isArabic(context) ? "علي مقلد" : "Ali Mekld",
            style: TextStyleHelper.of(context).bodyLarge16R.copyWith(
                  fontFamily: Constants.notoSansKoufyFontFamily,
                  fontSize: isExpanded ? 16 : 12,
                ),
          ),
          16.0.heightBox,
          Divider(
            thickness: 1,
            color: ColorsPalette.of(context).dividerColor,
          ),
          16.0.heightBox,
          ...menuList.mapIndexed(
            (i, e) => InkWell(
              borderRadius: Constants.kBorderRaduis8,
              onTap: () {
                context.goNamed(e.route);
                currentIndex = i;
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: Constants.kBorderRaduis8,
                  color: currentIndex == i
                      ? ColorsPalette.of(context).primaryColor
                      : null,
                ),
                height: 56.h,
                width: isExpanded ? 160 : 40,
                child: Row(
                  mainAxisSize:
                      isExpanded ? MainAxisSize.max : MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: isExpanded
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      e.imgSvg,
                      height: 20.h,
                      width: 20.w,
                      colorFilter: ColorFilter.mode(
                        currentIndex == i
                            ? Colors.white
                            : ColorsPalette.of(context).secondaryTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    if (isExpanded) ...[
                      16.0.widthBox,
                      Text(
                        e.title.tr,
                        style: TextStyleHelper.of(context)
                            .bodyMedium14R
                            .copyWith(
                              color: currentIndex == i ? Colors.white70 : null,
                            ),
                      ).expand,
                    ]
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  const DialogHelper.customDialog(child: SettingsDialog())
                      .showDialog(context);
                },
                icon: Icon(
                  Icons.settings,
                  size: 28,
                  color: ColorsPalette.of(context).primaryColor,
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
                  SharedPref.setIsSideBarExpanded(value: isExpanded);
                },
                icon: Icon(
                  isExpanded
                      ? Icons.arrow_back_ios_new
                      : Icons.arrow_forward_ios_outlined,
                  color: ColorsPalette.of(context).primaryColor,
                ),
              ),
              16.h.heightBox,
            ],
          ).expand,
        ],
      ),
    );
  }
}
