import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/constants/constamts.dart';
import 'package:masrof/utilites/extensions.dart';

import '../assets.dart';
import '../core/Language/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';



///--------------->DOCUMENTATION----------------------//
enum ButtonTypes { primary, secondary, outlined, disabled }

class CustomButtonWidget extends StatelessWidget {
  final ButtonTypes buttonTypes;
  final Color? color;
  final String? buttonTitle;
  final Widget? child;
  final TextStyle? titleStyle;
  final Function()? onTap;
  final bool isLoading;
  final double? height, width;
  final BuildContext currentContext;

  const CustomButtonWidget.custom({
    super.key,
    required this.child,
    this.buttonTitle,
    this.color,
    this.titleStyle,
    required this.buttonTypes,
    required this.onTap,
    this.isLoading = false,
    this.height,
    this.width,
    required this.currentContext,
  });

  /// NAMED CONSTRUCTORS FOR ALL BUTTON TYPES
  const CustomButtonWidget.primary({
    super.key,
    this.child,
    this.color,
    this.onTap,
    this.buttonTitle,
    this.titleStyle,
    this.isLoading = false,
    this.height,
        required this.currentContext,

    this.width,
  }) : buttonTypes = ButtonTypes.primary;

  const CustomButtonWidget.secondary({
    super.key,
    this.child,
        required this.currentContext,

    this.color,
    this.titleStyle,
    this.onTap,
    this.buttonTitle,
    this.isLoading = false,
    this.height,
    this.width,
  }) : buttonTypes = ButtonTypes.secondary;

  const CustomButtonWidget.outlined({
    super.key,
    this.buttonTitle,
    this.child,
        required this.currentContext,

    this.color,
    this.titleStyle,
    this.onTap,
    this.isLoading = false,
    this.height,
    this.width,
  }) : buttonTypes = ButtonTypes.outlined;
  const CustomButtonWidget.disabled({
    super.key,
    this.buttonTitle,
    this.child,
        required this.currentContext,

    this.color,
    this.titleStyle,
    this.onTap,
    this.isLoading = false,
    this.height,
    this.width,
  }) : buttonTypes = ButtonTypes.disabled;

  /// GET DECORATIONS BASED ON BUTTON TYPE
  BoxDecoration get primaryDecoration =>
      BoxDecoration(color: color ?? ColorsPalette.of(currentContext).primaryColor, borderRadius: Constants.kBorderRaduis16);
  BoxDecoration get outlineDecoration => BoxDecoration(
      color: color ?? Colors.transparent,
      borderRadius: Constants.kBorderRaduis16 ,
      border: Border.all(
        color: ColorsPalette.of(currentContext).secondaryTextColor,
      ));
  BoxDecoration get secondaryDecoration =>
      BoxDecoration(color: color ?? ColorsPalette.of(currentContext).secondaryColor, borderRadius: Constants.kBorderRaduis16);
  BoxDecoration get disabledDecoration =>
      BoxDecoration(color: color ?? ColorsPalette.of(currentContext).buttonColor, borderRadius: Constants.kBorderRaduis16);
  BoxDecoration _getDecoration() {
    switch (buttonTypes) {
      case ButtonTypes.primary:
        return primaryDecoration;
      case ButtonTypes.secondary:
        return secondaryDecoration;
      case ButtonTypes.outlined:
        return outlineDecoration;
      case ButtonTypes.disabled:
        return disabledDecoration;
    }
  }

  static CustomButtonWidget backButton(BuildContext context, {double? width}) => CustomButtonWidget.outlined(
      
      currentContext: context, width: width ?? 1.sw,
        buttonTitle: Strings.back.tr,
        onTap: () {
          context.pop();
        },
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Constants.kBorderRaduis16,
      onTap: onTap,
      child: Container(
        height: height ?? 54.h,
        width: width ?? 1.sw,
        decoration: _getDecoration(),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              ).center
            : child ??
                Text(
                  buttonTitle ?? "",
                  style: titleStyle ?? TextStyleHelper.of(context).titleMedium16M.copyWith(color: ColorsPalette.of(context).buttonColor),
                ).center,
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final String? title, img;

  const SaveButton({
    super.key,
    this.title,
    this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title ?? Strings.save.tr, style: TextStyleHelper.of(context).bodyLarge16R),
        if (img != null) ...{
          8.w.widthBox,
          SvgPicture.asset(
            /// todo add this asset  imagesCheckDuotone
            img ?? Assets.images.app_logo_svg,
          )
        }
      ],
    );
  }
}

class CreateButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;

  const CreateButton({
    super.key,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( title ?? Strings.save.tr),
            8.w.widthBox,
            SvgPicture.asset(
              ///todo add this asset  imagesPlus
              Assets.images.app_logo_svg,
              colorFilter: ColorFilter.mode(
                ColorsPalette.of(context).primaryTextColor,
                BlendMode.srcIn,
              ),
            )
          ],
        ));
  }
}