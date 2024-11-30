import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/gen/assets.gen.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/constants/constamts.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:masrof/widgets/cutom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

mixin DialogsMixin {
  Dialog errorDialog(
      {Priority? priority,
      required BuildContext context,
      required String message}) {
    return Dialog(
      elevation: 16,
      shadowColor: ColorsPalette.of(context).buttonDisabledColor,
      shape: RoundedRectangleBorder(borderRadius: Constants.kBorderRaduis16),
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: SizedBox(
        height: 400.h,
        width: 400.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              //todo add this asset
              Assets.images.appLogo,
              width: 112.w,
              height: 112.h,
              colorFilter: ColorFilter.mode(
                  ColorsPalette.of(context).errorColor, BlendMode.srcIn),
            ),
            24.h.heightBox,
            Row(
              children: [
                Container(
                  width: 16,
                  height: 1.sh,
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  color:
                      ColorsPalette.of(context).secondaryColor.withOpacity(0.8),
                ),
                Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color:
                          ColorsPalette.of(context).errorColor.withOpacity(0.1),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        message,
                        style: TextStyleHelper.of(context).titleMedium16M,
                      ),
                    )).heightBox(120.h).expand,
              ],
            ).heightBox(120.h),
            24.h.heightBox,
            CustomButtonWidget.backButton(context),
          ],
        ).addPaddingAll(padding: 16.r),
      ),
    );
  }

  Dialog successDialog(
      {required BuildContext context,
      required String message,
      Function()? onSuccess}) {
    return Dialog(
      elevation: 16,
      shadowColor: ColorsPalette.of(context).buttonDisabledColor,
      shape: RoundedRectangleBorder(borderRadius: Constants.kBorderRaduis16),
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: SizedBox(
        height: 400.h,
        width: 400.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.images.appLogo,
              width: 112.w,
              height: 112.h,
              colorFilter: ColorFilter.mode(
                  ColorsPalette.of(context).successColor, BlendMode.srcIn),
            ),
            24.h.heightBox,
            Row(
              children: [
                Container(
                  width: 16,
                  color:
                      ColorsPalette.of(context).secondaryColor.withOpacity(0.8),
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color:
                        ColorsPalette.of(context).successColor.withOpacity(0.1),
                  ),
                  child: Text(
                    message,
                    style: TextStyleHelper.of(context).titleMedium16M,
                  ),
                ).heightBox(120.h).expand,
              ],
            ).heightBox(120.h),
            24.h.heightBox,
            CustomButtonWidget.primary(
              currentContext: context,
              buttonTitle: Strings.save.tr,
              onTap: () {
                if (onSuccess != null) onSuccess();
                context.pop();
              },
            ),
          ],
        ).addPaddingAll(padding: 16.r),
      ),
    );
  }

  Dialog editDialog(
      {required BuildContext context,
      required String message,
      required Function() onConfirm}) {
    return Dialog(
      elevation: 28,
      shadowColor: ColorsPalette.of(context).secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: Constants.kBorderRaduis16,
      ),
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: SizedBox(
        height: 400.h,
        width: 400.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ///todo add this asset
              Assets.images.appLogo,
              width: 112.w,
              height: 112.h,
              colorFilter: ColorFilter.mode(
                  ColorsPalette.of(context).secondaryColor, BlendMode.srcIn),
            ),
            24.h.heightBox,
            Row(
              children: [
                Container(
                  width: 16,
                  color: ColorsPalette.of(context).secondaryColor,
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color:
                        ColorsPalette.of(context).watingColor.withOpacity(0.1),
                  ),
                  child: Text(
                    message,
                    style: TextStyleHelper.of(context).titleMedium16M,
                  ),
                ).heightBox(120.h).expand,
              ],
            ).heightBox(120.h),
            24.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget.backButton(context, width: 112.w),
                CustomButtonWidget.primary(
                  width: 120.w,
                  currentContext: context,
                  buttonTitle: Strings.confirm.tr,
                  onTap: onConfirm,
                ),
              ],
            ).widthBox(1.sw),
          ],
        ).addPaddingAll(padding: 16.r),
      ),
    );
  }

  Dialog deleteDialog(
      {required BuildContext context,
      required String message,
      required Function() onDelete}) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: Constants.kBorderRaduis16),
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: SizedBox(
        height: 400.h,
        width: 400.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ///todo add this asset  imagesWarningCircle
              Assets.images.appLogo,
              width: 112.w,
              height: 112.h,
              colorFilter: ColorFilter.mode(
                  ColorsPalette.of(context).errorColor, BlendMode.srcIn),
            ),
            24.h.heightBox,
            Row(
              children: [
                Container(
                  width: 16,
                  color:
                      ColorsPalette.of(context).secondaryColor.withOpacity(0.8),
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color:
                        ColorsPalette.of(context).watingColor.withOpacity(0.1),
                  ),
                  child: Text(
                    message,
                    style: TextStyleHelper.of(context).titleMedium16M,
                  ),
                ).heightBox(120.h).expand,
              ],
            ).heightBox(120.h),
            24.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget.backButton(context, width: 112.w),
                CustomButtonWidget.primary(
                  currentContext: context,
                  width: 120.w,
                  color: ColorsPalette.of(context).errorColor,
                  buttonTitle: Strings.delete.tr,
                  onTap: onDelete,
                ),
              ],
            ).widthBox(1.sw),
          ],
        ).addPaddingAll(padding: 16.r),
      ),
    );
  }

  Dialog dialogFrame(
      {required BuildContext context,
      required String message,
      Widget? child,
      double? height,
      width}) {
    return Dialog(
      elevation: 6,
      // alignment: AlignmentDirectional.bottomStart,
      surfaceTintColor: ColorsPalette.of(context).backgroundColor.withOpacity(0.1),
      shadowColor: ColorsPalette.of(context).buttonColor,
      shape: RoundedRectangleBorder(borderRadius: Constants.kBorderRaduis16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: child,
    );
  }
}
