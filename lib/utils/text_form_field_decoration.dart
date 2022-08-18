import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TextFormFieldDecoration {
  static InputDecoration outlinedFormFieldDecoration({
    required String hintText,
    required FocusNode focusNode,
    IconData? prefixIconIconData,
    IconButton? suffixIconButton,
    double? borderWidth,
    double? borderRadius,
    bool? filled,
    Color? filledColor,
  }) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: const EdgeInsets.only(top: 6, left: 12),
      hintStyle: kTitleSmall.copyWith(
          // color: focusNode.hasFocus ? kPrimaryColor : Colors.white70,
          ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: borderWidth ?? 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: borderWidth ?? 1.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: borderWidth ?? 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: borderWidth ?? 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: borderWidth ?? 1.0,
        ),
      ),
      fillColor: filledColor ?? Colors.transparent,
      filled: filled ?? false,
      prefixIcon: prefixIconIconData == null
          ? null
          : Icon(
              prefixIconIconData,
              color: kPrimaryColor,
            ),
      suffixIcon: suffixIconButton,
    );
  }

  static InputDecoration underlinedFormFieldDecoration({
    required String hintText,
    required FocusNode focusNode,
  }) {
    return InputDecoration(
      hintText: hintText,
      // contentPadding: const EdgeInsets.only(left: 8),
      hintStyle: kTitleSmall.copyWith(
          // color: focusNode.hasFocus ? kPrimaryColor : kWhite,
          ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
    );
  }
}
