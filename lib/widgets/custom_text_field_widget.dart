// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';

import '../utilites/constants/constamts.dart';

enum _DecorationType { focused, error, enabled, disabled, validated }

class CustomTextFieldWidget extends StatefulWidget {
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
  final List<TextInputFormatter>? formatters;
  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
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

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  OutlineInputBorder getInputDecoration({required _DecorationType type}) {
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

  Color getHintColor({_DecorationType? type}) {
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

  bool get isValidate =>
      widget.validator != null && widget.controller.text.isNotEmpty;

  InputDecoration get getDecoration => InputDecoration(
        errorStyle: const TextStyle(fontSize: 0, height: 0),
        labelStyle: TextStyleHelper.of(context).titleMedium16M,
        enabled: widget.enabled ?? true,
        hintText: widget.hintText ?? "",
        labelText: widget.lableText ?? "",
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
              onTap: widget.onSuffixTap,
              child: widget.suffix ?? const SizedBox()),
        ),
        prefixIconConstraints: const BoxConstraints(
            maxHeight: 32, maxWidth: 32, minHeight: 32, minWidth: 32),
        suffixIconConstraints: const BoxConstraints(
            maxHeight: 32, maxWidth: 48, minHeight: 32, minWidth: 32),
        border: getInputDecoration(type: _DecorationType.enabled),
        enabledBorder: getInputDecoration(type: _DecorationType.enabled),
        errorBorder: getInputDecoration(
          type: _DecorationType.error,
        ),
        focusedBorder: getInputDecoration(type: _DecorationType.focused),
        disabledBorder: getInputDecoration(type: _DecorationType.disabled),
      );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 58.h,
      width: widget.width ?? 320.w,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        inputFormatters: widget.formatters,
        autofocus: widget.autoFocus ?? false,
        decoration: getDecoration,
        enabled: widget.enabled ?? true,
        validator: widget.validator,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        textDirection:
            isArabic(context) ? TextDirection.rtl : TextDirection.ltr,
        textAlignVertical: TextAlignVertical.center,
        showCursor: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        style: TextStyleHelper.of(context).titleMedium16M,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onTap: widget.onTap,
        restorationId: "--",
        onSaved: widget.onSaved,
        autocorrect: true,
        onFieldSubmitted: widget.onFieldSubmitted ?? widget.onSaved,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        cursorWidth: 2.5.w,
        canRequestFocus: true,
        textAlign: TextAlign.start,
        readOnly: widget.isReadOnly ?? false,
        clipBehavior: Clip.antiAlias,
        cursorColor:
            ColorsPalette.of(context).primaryTextColor.withOpacity(0.6),
        cursorRadius: const Radius.circular(4),
        cursorErrorColor: ColorsPalette.of(context).errorColor,
        enableSuggestions: widget.enabled != null ? true : false,
        enableInteractiveSelection: true,
        expands: widget.expands ?? false,
        onTapAlwaysCalled: false,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText ?? false,
        minLines: widget.minLines ?? 1,
        maxLines: widget.maxLines ?? 1,
      ),
    );
  }
}
