// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:provider/provider.dart';

import '../core/Language/language_provider.dart';
import '../utilites/constants/constamts.dart';

enum _DecorationType { focused, error, enabled, disabled, validated }

class CustomTextFieldWidget extends StatelessWidget {
  static List<TextInputFormatter> get decimalFormatters =>
      [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))];
  final TextEditingController controller;
  final String? Function(String?)? validator;

  final double? width, height;
  final bool? autoFocus,
      enabled,
      expands,
      ignorePointer,
      obscureText,
      isReadOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function()? onTap, onSuffixTap;
  final void Function(String?)? onSaved, onChanged, onFieldSubmitted;
  final void Function()? onEditingComplete;
  final int? maxLines, minLines;
  final TextDirection? textDirection;
  final TextInputType? textInputType;
  final String? lableText, hintText;
  final Widget? suffix, prefix;
  final String? errorText;
  final List<TextInputFormatter>? formatters;
  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
    this.errorText,
    this.autoFocus = false,
    this.enabled = true,
    this.validator,
    this.textInputAction,
    this.textDirection,
    this.onTap,
    this.onSaved,
    this.maxLines,
    this.onEditingComplete,
    this.onChanged,
    this.onFieldSubmitted,
    this.expands,
    this.ignorePointer,
    this.textInputType,
    this.minLines,
    this.obscureText = false,
    this.hintText,
    this.lableText,
    this.prefix,
    this.suffix,
    this.isReadOnly,
    this.onSuffixTap,
    this.width,
    this.height,
    this.formatters,
  });

  OutlineInputBorder getInputDecoration(
      {required _DecorationType type, required BuildContext context}) {
    switch (type) {
      case _DecorationType.focused:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
                color: ColorsPalette.of(context)
                    .primaryTextColor
                    .withValues(alpha: 0.5),
                width: 1.5));
      case _DecorationType.error:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).errorColor,
            ));
      case _DecorationType.enabled:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).iconColor,
            ));
      case _DecorationType.disabled:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).buttonDisabledColor,
            ));
      case _DecorationType.validated:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).successColor,
            ));
    }
  }

  // ignore: library_private_types_in_public_api
  Color getHintColor({_DecorationType? type, required BuildContext context}) {
    //NOT WORKING
    switch (type) {
      case _DecorationType.error:
        return ColorsPalette.of(context).errorColor;
      case _DecorationType.focused:
      case _DecorationType.validated:
      case _DecorationType.enabled:
        return ColorsPalette.of(context).primaryTextColor;
      case _DecorationType.disabled:
        return ColorsPalette.of(context).secondaryTextColor;
      case null:
        return ColorsPalette.of(context).primaryTextColor;
    }
  }

  bool get isValidate => validator != null && controller.text.isNotEmpty;

  InputDecoration getDecoration(BuildContext context) => InputDecoration(
        errorText: errorText,
        errorStyle: TextStyle(fontSize: 16.sp, height: 0),
        labelStyle: TextStyleHelper.of(context).titleMedium16M,
        enabled: enabled ?? true,
        hintText: hintText ?? "",
        alignLabelWithHint: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelText: lableText ?? "",
        suffixIcon: GestureDetector(
          onTap: onSuffixTap,
          child: suffix ?? const SizedBox(),
        ),
        prefixIconConstraints: const BoxConstraints(
            maxHeight: 32, maxWidth: 32, minHeight: 32, minWidth: 32),
        // suffixIconConstraints: const BoxConstraints(
        //     maxHeight: 32, maxWidth: 48, minHeight: 32, minWidth: 32),
        border:
            getInputDecoration(type: _DecorationType.enabled, context: context),
        enabledBorder:
            getInputDecoration(type: _DecorationType.enabled, context: context),
        errorBorder:
            getInputDecoration(type: _DecorationType.error, context: context),
        focusedBorder:
            getInputDecoration(type: _DecorationType.focused, context: context),
        disabledBorder: getInputDecoration(
            type: _DecorationType.disabled, context: context),
      );

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.email);
    return SizedBox(
      width: width ?? 320.w,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        inputFormatters: formatters,
        autofocus: autoFocus ?? false,
        decoration: getDecoration(context),
        enabled: enabled ?? true,
        validator: validator,
        textInputAction: textInputAction ?? TextInputAction.next,
        textDirection:
            Provider.of<LanguageProvider>(context).appLang.languageCode == "ar"
                ? TextDirection.rtl
                : TextDirection.ltr,
        showCursor: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        style: TextStyleHelper.of(context).titleMedium16M,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onTap: onTap,
        restorationId: "--",
        onSaved: onSaved,
        autocorrect: true,
        onFieldSubmitted: onFieldSubmitted ?? onSaved,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        cursorWidth: 1.5.w,
        canRequestFocus: true,
        // textAlign: isArabic(context) ? TextAlign.right : TextAlign.left,
        readOnly: isReadOnly ?? false,
        clipBehavior: Clip.antiAlias,
        cursorColor:
            ColorsPalette.of(context).primaryTextColor.withOpacity(0.6),
        cursorRadius: const Radius.circular(4),
        cursorErrorColor: ColorsPalette.of(context).errorColor,
        enableSuggestions: enabled != null ? true : false,
        enableInteractiveSelection: true,
        expands: expands ?? false,
        onTapAlwaysCalled: false,
        keyboardType: textInputType,
        obscureText: obscureText ?? false,
        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
      ),
    );
  }
}
